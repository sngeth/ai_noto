require "spec_helper"

describe AiNoto do
  before(:each) do
    stub_const("AiNoto::ACCOUNT_SID", account_sid)
    stub_const("AiNoto::AUTH_TOKEN", auth_token)
  end

  it "has a version number" do
    expect(AiNoto::VERSION).not_to be nil
  end

  let(:contents) { "Hello World!" }

  it "reads in a note from command line into a Message" do
    allow(STDIN).to receive(:gets) { "Hello World!" }
    allow_any_instance_of(AiNoto::Message).to receive(:send_sms!)
    client = double('twilio client')
    allow(AiNoto).to receive(:twilio_client) { client }

    expect(STDOUT).to receive(:puts).with("Please enter your message:")
    expect(AiNoto::Message).to receive(:new).with(contents, client)
      .and_call_original

    subject.run
  end

  let(:account_sid) { 'ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' }
  let(:auth_token) { 'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy' }

  it "sets up Twilio" do
    expect(Twilio::REST::Client).to receive(:new)
      .with(account_sid, auth_token)

    subject.twilio_client
  end

  it "sends a note as a SMS" do
    sms_message = { from: AiNoto.from_number, to: AiNoto.to_number, body: 'hello' }
    messages = double('messages', create: sms_message)

    client = double('twilio client')
    allow(client).to receive_message_chain("api.account.messages") { messages }

    message = AiNoto::Message.new('hello', client)

    expect(client.api.account.messages).to receive(:create).with(sms_message)

    message.send_sms!
  end

  context "Configuring twilio message params" do
    it "reads 'from' number from yaml config" do
      expect(AiNoto.from_number).to eq '+19045745217'
    end

    it "reads 'to' number from yaml config" do
      expect(AiNoto.to_number).to eq "+19041112222"
    end
  end
end
