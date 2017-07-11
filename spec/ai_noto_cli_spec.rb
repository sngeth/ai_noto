require "spec_helper"
require "ai_noto"
require "ai_noto_cli"
require "byebug"

describe AiNotoCLI do
  let(:message) { "Hello World!" }

  it "#new" do
    expect(AiNoto).to receive(:send).with(message)
    subject.new(message)
  end
end
