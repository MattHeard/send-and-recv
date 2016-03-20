require_relative "../file_sender.rb"

RSpec.describe FileSender do
  context "with a file containing 'abc'" do
    it "sends 'abc'" do
      in_file_contents = "abc"
      in_file = StringIO.new(in_file_contents)
      in_stream = StringIO.new
      out_stream = StringIO.new
      args = { in_file: in_file, in_stream: in_stream, out_stream: out_stream }
      file_sender = FileSender.new(args)
      file_sender.call
      expect(out_stream.string).to eq in_file_contents
    end
  end
end
