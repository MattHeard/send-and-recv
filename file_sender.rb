require 'digest'

class FileSender
  FILE_NOT_RECEIVED = false
  IN_FILE_NAME = "input.txt"

  attr_reader :in_file, :in_stream, :out_stream, :strategies

  def initialize(args = {})
    args = defaults.merge(args)

    @in_file = args[:in_file]
    @in_stream = args[:in_stream]
    @out_stream = args[:out_stream]
    @strategies = args[:strategies]
  end

  def call
    strategies.inject(FILE_NOT_RECEIVED) do |file_received, strategy|
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
