class FileSender
  attr_reader :out_stream

  def initialize(args)
    @out_stream = args[:out_stream]
  end

  def call
    out_stream.print("abc")
  end
end
