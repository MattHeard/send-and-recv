class FileSender
  IN_FILE_NAME = "input.txt"

  attr_reader :in_file, :out_stream

  def initialize(args = {})
    args = defaults.merge(args)

    @in_file = args[:in_file]
    @out_stream = args[:out_stream]
  end

  def call
    in_file_contents = in_file.string

    out_stream.print(in_file_contents)
  end

  private

  def defaults
    default_in_file = File.readlines(IN_FILE_NAME)

    { :in_file => default_in_file, :out_stream => STDOUT }
  end
end
