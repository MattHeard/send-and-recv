require 'digest'

class FileSender
  FILE_NOT_RECEIVED = false
  IN_FILE_NAME = "input.txt"
  STRATEGIES = %i{ digest_strategy send_file_strategy }

  attr_accessor :digest_match_response

  attr_reader :in_file, :in_stream, :out_stream

  def initialize(args = {})
    args = defaults.merge(args)

    @in_file = args[:in_file]
    @in_stream = args[:in_stream]
    @out_stream = args[:out_stream]
  end

  def call
    STRATEGIES.inject(FILE_NOT_RECEIVED) do |file_received, strategy|
      file_received || send(strategy)
    end
  end

  private

  def send_file
    out_stream.print(in_file_contents)
  end

  def digest_strategy
    send_file_digest
    receive_digest_match_response

    file_already_received?
  end

  def send_file_strategy
    send_file

    true
  end

  def defaults
    default_in_file = File.readlines(IN_FILE_NAME)

    { :in_file => default_in_file, :out_stream => STDOUT }
  end

  def receive_digest_match_response
    self.digest_match_response = in_stream.gets
  end

  def file_already_received?
    digest_matches?
  end

  def digest_matches?
    digest_match_response != "0"
  end

  def send_file_digest
    out_stream.puts(in_file_digest)
  end

  def in_file_digest
    Digest::MD5.new.update(in_file_contents).hexdigest
  end

  def in_file_contents
    in_file.string
  end
end
