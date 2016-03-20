require_relative "../file_sender.rb"

RSpec.describe FileSender do
  let(:file_sender) { FileSender.new(file_sender_args) }
  let(:file_sender_args) do
    { in_file: in_file, in_stream: in_stream, out_stream: out_stream }
  end
  let(:out_stream) { StringIO.new }
  let(:in_file) { StringIO.new(in_file_contents) }

  before { file_sender.call }

  context "when the checksum of the file matches" do
    let(:in_stream) { StringIO.new("1") }

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
    let(:in_stream) { StringIO.new("0") }

    context "and the file contains 'abc'" do
      let(:checksum_and_file_contents) { "900150983cd24fb0d6963f7d28e17f72\nabc" }
      let(:in_file_contents) { "abc" }

      it "sends the checksum and the file contents" do
        expect(out_stream.string).to eq checksum_and_file_contents
      end
    end

    context "and the file contains 'abcde'" do
      let(:checksum_and_file_contents) { "ab56b4d92b40713acc5af89985d4b786\nabcde" }
      let(:in_file_contents) { "abcde" }

      it "sends the checksum and the file contents" do
        expect(out_stream.string).to eq checksum_and_file_contents
      end
    end
  end
end
