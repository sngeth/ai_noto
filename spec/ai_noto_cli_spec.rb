require "spec_helper"
require "ai_noto"
require "ai_noto_cli"
require "byebug"


describe AiNotoCLI do
  before(:each) do
    allow(File).to receive(:exists?) { true }
    allow(AiNoto).to receive(:config_file) { "#{Dir.pwd}/lib/config.test.yml" }
  end

  let(:message) { "Hello World!" }

  it "#new with no specific user" do
    expect(AiNoto).to receive(:send).with(nil, message)
    subject.new(nil, message)
  end

  it "#new with specific person" do
    expect(AiNoto).to receive(:send).with("Ashley", message)
    subject.new("Ashley", message)
  end
end
