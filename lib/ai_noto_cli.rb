require 'thor'
require 'byebug'

# Command line suite
#
# Available commands:
# new
class AiNotoCLI < Thor
  include AiNoto

  desc 'new "MESSAGE"', 'send a new "MESSAGE" to default person'
  def new(message)
    puts "Sending a message to #{AiNoto.to_number}"
    AiNoto.send(message)
  end
end

AiNotoCLI.start(ARGV)
