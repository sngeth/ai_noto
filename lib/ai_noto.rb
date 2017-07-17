require "twilio-ruby"
require "yaml"
require "message"

module AiNoto
  def self.send(recipient, contents)
    Message.new(contents, twilio_client, recipient).send_sms!
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

  def self.default_recipient
    YAML.load_file(config_file)["default_recipient"]
  end

  def self.from_number
    YAML.load_file(config_file)["from_number"]
  end

  def self.to_number(recipient = nil)
    recipient = recipient.nil? ? default_recipient : YAML.load_file(config_file)[recipient]
  end

  def self.config_file
    File.join(Dir.home, ".ai_noto.rc.yml")
  end
end
