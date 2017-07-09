require 'twilio-ruby'

module AiNoto
  ACCOUNT_SID = ENV["twilio_account_sid"]
  AUTH_TOKEN = ENV["twilio_auth_token"]

  def self.run
    puts "Please enter your message:"
    Message.new($stdin.gets.chomp)
  end

  def self.setup_twilio
    Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
  end

  class Message
    attr_accessor :contents

    def initialize(contents)
      @contents = contents
    end
  end
end
