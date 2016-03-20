# Send and Recv

An Explosion Monday challenge

## Challenge description

> Create a pair of programs that transfer a file from the server to the client
> over `stdin`/`stdout`.  A file that’s similar to the remote file might exist
> on the local server already.  The winner will be the correct implementation
> that transfers a series of supplied files with the fewest bytes.

> If the local file doesn’t exist, `recv` should create it.  If it does exist,
> `recv` should use it as a base for the incoming file.

> Start by getting `send` and `recv` just transferring the file, ignoring
> whatever is in the local file.
