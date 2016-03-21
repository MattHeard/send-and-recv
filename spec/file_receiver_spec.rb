require_relative "../file_receiver.rb"

RSpec.describe FileReceiver do
  let(:file_receiver) { FileReceiver.new(file_receiver_args) }
  let(:file_receiver_args) do
    { out_file: out_file, in_stream: in_stream, out_stream: out_stream }
  end
  let(:out_stream) { StringIO.new }
  let(:in_stream) { StringIO.new(in_stream_contents) }
  let(:out_file) { StringIO.new(out_file_contents) }
  let(:out_file_contents) { "" }
  let(:expected_out_file_contents) { out_file_contents }

  before { file_receiver.call }

  context "when the out_file is empty" do
    context "receiving the checksum of then contents of 'abc'" do
      let(:in_stream_contents) { "900150983cd24fb0d6963f7d28e17f72\nabc" }
      let(:expected_out_file_contents) { "abc" }

      it "puts '0' in the out stream" do
        expect(out_stream.string).to eq "0\n"
      end

      it "puts 'abc' in the output file" do
        expect(out_file.string).to eq in_stream_contents
      end
    end

    context "receiving the checksum of then contents of 'abcde'" do
      let(:in_stream_contents) { "ab56b4d92b40713acc5af89985d4b786\nabcde" }
      let(:expected_out_file_contents) { "abcde" }

      it "puts '0' in the out stream" do
        expect(out_stream.string).to eq "0\n"
      end

      it "puts 'abcde' in the output file" do
        expect(out_file.string).to eq in_stream_contents
      end
    end
  end

  context "when the out_file contains 'abc'" do
    let(:out_file_contents) { "abc" }

    context "receiving only the checksum of 'abc'" do
      let(:in_stream_contents) { "900150983cd24fb0d6963f7d28e17f72\n" }

      it "puts '1' in the out stream" do
        expect(out_stream.string).to eq "1\n"
      end

      it "leaves 'abc' in the output file" do
        expect(out_file.string).to eq expected_out_file_contents
      end
    end
  end

  context "when the out_file contains 'abcde'" do
    let(:out_file_contents) { "abcde" }

    context "receiving only the checksum of 'abcde'" do
      let(:in_stream_contents) { "ab56b4d92b40713acc5af89985d4b786\n" }

      it "puts '1' in the out stream" do
        expect(out_stream.string).to eq "1\n"
      end

      it "leaves 'abcde' in the output file" do
        expect(out_file.string).to eq expected_out_file_contents
      end
    end
  end
end
