require 'stringio'

def capture_stdout
  @@output = StringIO.new
  @@input = StringIO.new("y\n")
  yield
  @@output.string.strip
ensure
  @@output = $stdout
  @@input = $stdin
end
