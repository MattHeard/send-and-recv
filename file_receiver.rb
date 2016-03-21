require 'digest'

class FileReceiver
  DIGEST_NOT_MATCHING = "0"
  DIGEST_MATCHING = "1"

  attr_accessor :sent_digest
  attr_reader :in_stream, :out_stream, :out_file

  def initialize(args = {})
    @in_stream = args[:in_stream]
    @out_stream = args[:out_stream]
    @out_file = args[:out_file]
  end

  def call
    receive_file_digest
    send_digest_match

    update_out_file
  end

  private

  def digest_matched?
    sent_digest == (out_file_digest + "\n")
  end

  def out_file_digest
    Digest::MD5.new.update(out_file_contents).hexdigest
  end

  def out_file_contents
    out_file.string
  end

  def receive_file_digest
    self.sent_digest = in_stream.gets
  end

  def send_digest_match
    out_stream.puts digest_match_response
  end

  def digest_match_response
    digest_matched? ? DIGEST_MATCHING : DIGEST_NOT_MATCHING
  end

  def update_out_file
    out_file.print(in_stream_contents)
  end

  def in_stream_contents
    in_stream.string
  end
end
