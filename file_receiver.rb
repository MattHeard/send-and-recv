class FileReceiver
  attr_reader :in_stream, :out_file

  def initialize(args = {})
    @in_stream = args[:in_stream]
    @out_file = args[:out_file]
  end

  def call
    in_stream_contents = in_stream.string

    out_file.print(in_stream_contents)
  end
end
