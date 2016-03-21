require_relative 'strategy'

class DigestStrategy < Strategy
  def call
    send_file_digest
    receive_digest_match_response

    file_already_received?
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

  def file_already_received?
    digest_matches?
  end

  def digest_matches?
    digest_match_response != "0\n"
  end
end
