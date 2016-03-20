class FileReceiver
  attr_reader :out_file

  def initialize(args)
    @out_file = args[:out_file]
  end

  def call
    out_file.print("abc")
  end
end
