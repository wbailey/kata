def capture_stdout
  require 'stringio'

  orig_stdout, orig_stdin         = $stdout, $stdin
  captured_stdout, captured_stdin = StringIO.new, StringIO.new("y\n")
  $stdout, $stdin                 = captured_stdout, captured_stdin

  yield

  return captured_stdout.string.chomp
ensure
  $stdout = orig_stdout
  $stdin = orig_stdin
end