#!/usr/bin/env ruby
# Glue for `send` and `recv`, provided by Steve Purcell.

if ARGV.length != 2
  fail "takes only two arguments"
end

r1, w1 = IO.pipe
r2, w2 = IO.pipe

if fork
  STDIN.reopen(r1)
  STDOUT.reopen(w2)
  exec ARGV[1]
else
  STDIN.reopen(r2)
  STDOUT.reopen(w1)
  exec ARGV[0]
end
