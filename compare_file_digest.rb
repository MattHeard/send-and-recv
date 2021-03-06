require_relative 'file_sending_strategy'

class CompareFileDigest < FileSendingStrategy
  def call
    send_file_digest
    receive_digest_match_response

    digest_matches?
  end

  private

  attr_accessor :digest_match_response

  def send_file_digest
    out_stream.puts(in_file_digest)
  end

  def in_file_digest
    Digest::MD5.new.update(in_file.string).hexdigest
  end

  def receive_digest_match_response
    self.digest_match_response = in_stream.gets
  end

  def digest_matches?
    digest_match_response != "0\n"
  end
end
