class FileSender
  attr_reader :in_file, :out_stream

  def initialize(args)
    @in_file = args[:in_file]
    @out_stream = args[:out_stream]
  end

  def call
    in_file_contents = in_file.string

    out_stream.print(in_file_contents)
  end
end
