require 'twilio-ruby'

module AiNoto
  ACCOUNT_SID = ENV["TWILIO_ACCOUNT_SID"]
  AUTH_TOKEN = ENV["TWILIO_AUTH_TOKEN"]

  def self.run
    puts "Please enter your message:"
    contents = $stdin.gets.chomp
    Message.new(contents, twilio_client).send_sms!
  end

  def self.twilio_client
    Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
  end

  class Message
    attr_accessor :contents, :twilio_client

    def initialize(contents, twilio_client)
      @contents = contents
      @twilio_client = twilio_client
    end

    def send_sms!
      twilio_client.api.account.messages.create(from: '+19045745217',
                                                to: '+19045716868',
                                                body: contents)
    end
  end
end
