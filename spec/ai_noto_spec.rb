require "spec_helper"

describe AiNoto do
  it "has a version number" do
    expect(AiNoto::VERSION).not_to be nil
  end

  context "Main interface" do
    let(:message) { "Hello World!" }

    it "reads in a note from command line into a Message" do
      expect(STDOUT).to receive(:puts).with("Please enter your message:")
      allow(STDIN).to receive(:gets) { message }
      expect(AiNoto::Message).to receive(:new).with(message)

      subject.run
    end

    let(:account_sid) { 'ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' }
    let(:auth_token) { 'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy' }

    it "sets up Twilio" do
      stub_const("AiNoto::ACCOUNT_SID", account_sid)
      stub_const("AiNoto::AUTH_TOKEN", auth_token)

      expect(Twilio::REST::Client).to receive(:new)
        .with(account_sid, auth_token)

      subject.setup_twilio
    end
  end
end
