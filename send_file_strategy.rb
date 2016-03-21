require_relative 'file_sending_strategy'

class SendFileStrategy < FileSendingStrategy
  def call
    send_file

    true
  end

  private

  def send_file
    out_stream.print(in_file_contents)
  end

  def in_file_contents
    in_file.string
  end
end
