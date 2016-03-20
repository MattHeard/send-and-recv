require_relative "../file_receiver.rb"

RSpec.describe FileReceiver do
  let(:file_receiver) { FileReceiver.new(file_receiver_args) }
  let(:file_receiver_args) do
    { out_file: out_file, in_stream: in_stream, out_stream: out_stream }
  end
  let(:out_stream) { StringIO.new }
  let(:in_stream) { StringIO.new(in_stream_contents) }
  let(:out_file) { StringIO.new }

  context "receiving 'abc'" do
    let(:in_stream_contents) { "abc" }

    before { file_receiver.call }

    it "puts 'abc' in the output file" do
      expect(out_file.string).to eq in_stream_contents
    end
  end
end
