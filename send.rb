#!/usr/bin/env ruby

require_relative "file_sender"

args = { strategies: [ CompareFileDigest, SendFile ] }

FileSender.new(args) if __FILE__ == $PROGRAM_NAME
