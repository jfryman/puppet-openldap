require 'sha1'
require 'base64'

module Puppet::Parser::Functions newfunction(:ssha, 
    :type => :rvalue, 
    :doc => "Returns a SSHA has from a provided string") 
  do |args|
    chars = ('a'..'z').to_a + ('0'..'9').to_a
    salt = Array.new(10/2) { rand(256) }.pack('C*').unpack('H*').first
    '{SSHA}' + Base64.encode64( Digest::SHA1.digest(args+salt)+salt ).chomp!   
  end
end