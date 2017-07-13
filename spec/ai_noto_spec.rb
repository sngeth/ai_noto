require "spec_helper"

describe AiNoto do
  before(:each) do
    stub_const("AiNoto::ACCOUNT_SID", account_sid)
    stub_const("AiNoto::AUTH_TOKEN", auth_token)
  end

  it "has a version number" do
    expect(AiNoto::VERSION).not_to be nil
  end

  let(:account_sid) { "1234" }
  let(:auth_token) { "1234" }
  let(:twilio_credentials) do
    [account_sid, auth_token]
  end

  it "sets up Twilio" do
    expect(Twilio::REST::Client).to receive(:new)
      .with(account_sid, auth_token)

    subject.twilio_client
  end

  describe "#to_number" do
    it "gets the default recipient" do
      expect(AiNoto.to_number).to eq "+18001234567"
    end

    it "gets a specified recipient" do
      expect(AiNoto.to_number("Ashley")).to eq "+18001112222"
    end
  end

  it "sends a note as a SMS to recipieint" do
    sms_message = { from: AiNoto.from_number,
                    to: AiNoto.to_number,
                    body: "hello" }

    messages = double("messages", create: sms_message)

    client = double("twilio client")
    allow(client).to receive_message_chain("api.account.messages") { messages }

    message = AiNoto::Message.new("hello", client, nil)

    expect(client.api.account.messages).to receive(:create).with(sms_message)

    message.send_sms!
  end

  it "sends a note as a SMS to a specific recipieint" do
    sms_message = { from: AiNoto.from_number,
                    to: AiNoto.to_number("Ashley"),
                    body: "hello" }

    messages = double("messages", create: sms_message)

    client = double("twilio client")
    allow(client).to receive_message_chain("api.account.messages") { messages }

    message = AiNoto::Message.new("hello", client, "Ashley")

    expect(client.api.account.messages).to receive(:create).with(sms_message)

    message.send_sms!
  end

  context "Configuring twilio message params" do
    it "reads twilio credentials" do
      expect(YAML).to receive(:load_file).with("#{Dir.pwd}/lib/config.test.yml")
        .and_call_original
      expect(AiNoto.twilio_credentials).to eq [account_sid, auth_token]
    end

    it "reads a default recipient from yaml config" do
      expect(AiNoto.default_recipient).to eq  "+18001234567"
    end

    it "reads 'from' number from yaml config" do
      expect(AiNoto.from_number).to eq "+19045745217"
    end

    it "reads 'to' number from yaml config" do
      expect(AiNoto.to_number).to eq "+18001234567"
    end
  end
end
