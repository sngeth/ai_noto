require 'thor'
require 'byebug'

# Command line suite
#
# Available commands:
# new
class AiNotoCLI < Thor
  include AiNoto

  desc 'new [recipient] "MESSAGE"', 'send a new "MESSAGE" to recipient'
  def new(recipient=nil, message)
    puts "Sending a message to #{AiNoto.to_number(recipient)}"
    AiNoto.send(recipient, message)
  end
end

AiNotoCLI.start(ARGV)
