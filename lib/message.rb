class Message
  attr_accessor :contents, :twilio_client, :recipient

  def initialize(contents, twilio_client, recipient)
    @contents = contents
    @twilio_client = twilio_client
    @recipient = recipient
  end

  def send_sms!
    twilio_client.api.account.messages.create(from: AiNoto.from_number,
                                              to: AiNoto.to_number(recipient),
                                              body: contents)
  end
end
