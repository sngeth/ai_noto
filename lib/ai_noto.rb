require 'twilio-ruby'
require 'yaml'

module AiNoto
  ACCOUNT_SID = ENV["TWILIO_ACCOUNT_SID"]
  AUTH_TOKEN = ENV["TWILIO_AUTH_TOKEN"]

  def self.send(contents)
    Message.new(contents, twilio_client).send_sms!
  end

  def self.twilio_client
    Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
  end

  def self.from_number
    file = File.join(Dir.pwd, 'lib', config)
    YAML.load_file(file)["from_number"]
  end

  def self.to_number
    file = File.join(Dir.pwd, 'lib', config)
    YAML.load_file(file)["to_number"]
  end

  def self.config
    ENV['TEST'] ? 'config.test.yml' : 'config.yml'
  end

  class Message
    attr_accessor :contents, :twilio_client

    def initialize(contents, twilio_client)
      @contents = contents
      @twilio_client = twilio_client
    end

    def send_sms!
      twilio_client.api.account.messages.create(from: AiNoto.from_number,
                                                to: AiNoto.to_number,
                                                body: contents)
    end
  end
end
