require 'digest'
require_relative 'digest_strategy'
require_relative 'send_file_strategy'

class FileSender
  FILE_NOT_RECEIVED = false
  IN_FILE_NAME = "input.txt"
  STRATEGIES = [ DigestStrategy, SendFileStrategy ]

  attr_reader :in_file, :in_stream, :out_stream

  def initialize(args = {})
    args = defaults.merge(args)

    @in_file = args[:in_file]
    @in_stream = args[:in_stream]
    @out_stream = args[:out_stream]
  end

  def call
    STRATEGIES.inject(FILE_NOT_RECEIVED) do |file_received, strategy|
      file_received || strategy.new(strategy_args).call
    end
  end

  private

  def strategy_args
    { in_file: in_file, in_stream: in_stream, out_stream: out_stream }
  end

  def defaults
    default_in_file = File.readlines(IN_FILE_NAME)

    { :in_file => default_in_file, :out_stream => STDOUT }
  end
end
