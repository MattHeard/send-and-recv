class FileSendingStrategy
  attr_reader :in_file, :in_stream, :out_stream

  def initialize(args)
    @in_file = args[:in_file]
    @in_stream = args[:in_stream]
    @out_stream = args[:out_stream]
  end

  def call
    raise NotImplementedError
  end
end
