require 'webrick'
require 'rexml/document'
require 'json'

require_relative 'lib/liquid'
require_relative 'liquid_servlet'
require_relative 'announcement_servlet.rb'

# Setup webrick
server = WEBrick::HTTPServer.new(Port: ARGV[1] || 3000,DocumentRoot:"./")
server.mount('/', Servlet)
trap("INT"){ server.shutdown }
server.start
