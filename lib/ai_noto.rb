require "twilio-ruby"
require "yaml"

module AiNoto
  def self.send(contents)
    Message.new(contents, twilio_client).send_sms!
  end

  def self.twilio_client
    account_sid, auth_token = twilio_credentials
    Twilio::REST::Client.new(account_sid, auth_token)
  end

  def self.twilio_credentials
    config = YAML.load_file(config_file)

    [config["twilio_account_sid"],
      config["twilio_auth_token"]]
  end

  def self.from_number
    YAML.load_file(config_file)["from_number"]
  end

  def self.to_number
    YAML.load_file(config_file)["to_number"]
  end

  def self.config
    ENV["TEST"] ? "config.test.yml" : "config.yml"
  end

  def self.config_file
    file = File.join(Dir.pwd, "lib", config)
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
