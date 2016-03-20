require_relative "../file_sender.rb"

RSpec.describe FileSender do
  context "with a file containing 'abc'" do
    let(:file_sender) { FileSender.new(file_sender_args) }
    let(:file_sender_args) do
      { in_file: in_file, in_stream: in_stream, out_stream: out_stream }
    end
    let(:out_stream) { StringIO.new }
    let(:in_stream) { StringIO.new }
    let(:in_file_contents) { "abc" }
    let(:in_file) { StringIO.new(in_file_contents) }

    before { file_sender.call }

    it "sends 'abc'" do
      expect(out_stream.string).to eq in_file_contents
    end
  end
end
