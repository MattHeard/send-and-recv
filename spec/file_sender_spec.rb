require_relative "../file_sender"
require_relative "../compare_file_digest"
require_relative "../send_file"

RSpec.describe FileSender do
  let(:file_sender) { FileSender.new(file_sender_args) }
  let(:file_sender_args) do
    { in_file: in_file, in_stream: in_stream, out_stream: out_stream, strategies: strategies }
  end
  let(:strategies) { [ CompareFileDigest, SendFile ] }
  let(:out_stream) { StringIO.new }
  let(:in_file) { StringIO.new(in_file_contents) }

  before { file_sender.call }

  context "when the checksum of the file matches" do
    let(:in_stream) { StringIO.new("1\n") }

    context "and the file contains 'abc'" do
      let(:in_file_contents) { "abc" }
      let(:only_checksum) { "900150983cd24fb0d6963f7d28e17f72\n" }

      it "sends only the checksum" do
        expect(out_stream.string).to eq only_checksum
      end
    end

    context "and the file contains 'abcde'" do
      let(:in_file_contents) { "abcde" }
      let(:only_checksum) { "ab56b4d92b40713acc5af89985d4b786\n" }

      it "sends only the checksum" do
        expect(out_stream.string).to eq only_checksum
      end
    end
  end

  context "when the checksum of the file does not match" do
    let(:in_stream) { StringIO.new("0\n") }

    context "and the file contains 'abc'" do
      let(:checksum_and_file_contents) do
        "900150983cd24fb0d6963f7d28e17f72\nabc"
      end
      let(:in_file_contents) { "abc" }

      it "sends the checksum and the file contents" do
        expect(out_stream.string).to eq checksum_and_file_contents
      end
    end

    context "and the file contains 'abcde'" do
      let(:checksum_and_file_contents) do
        "ab56b4d92b40713acc5af89985d4b786\nabcde"
      end
      let(:in_file_contents) { "abcde" }

      it "sends the checksum and the file contents" do
        expect(out_stream.string).to eq checksum_and_file_contents
      end
    end
  end
end
