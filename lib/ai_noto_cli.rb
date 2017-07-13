require 'thor'

# Command line suite
#
# Available commands:
# init
# new
class AiNotoCLI < Thor
  CONFIG_FILE = File.join(Dir.home, ".ai_noto.rc.yml")

  desc 'init', 'initializes twilio configuration'
  def init
    options = {
      "from_number" => "+18001234567",
      "to_number" => "+18001234567",
      "twilio_account_sid" => "enter your account sid",
      "twilio_auth_token" => "enter your auth token",
      "default_recipient" => "+18001234567",
      "John" => "+18001112222",
    }

    if !File.exists? CONFIG_FILE
      File.open(CONFIG_FILE, 'w') { |file| YAML::dump(options, file) }
      STDOUT.puts "Initialized default configuration file in #{CONFIG_FILE}"
      STDOUT.puts "Please ensure it properly configured"
    else
      STDOUT.puts "Configuration file already exists in #{CONFIG_FILE}"
    end
  end

  desc 'new [recipient] "MESSAGE"', 'send a new "MESSAGE" to recipient'
  def new(recipient=nil, message)
    raise RuntimeError, "No configuration found, please run ainoto init" if !File.exists? CONFIG_FILE

    puts "Sending a message to #{AiNoto.to_number(recipient)}"
    AiNoto.send(recipient, message)
  end
end

AiNotoCLI.start(ARGV)
