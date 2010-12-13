def capture_stdout
  @@output = StringIO.new
  yield
  @@output.string.strip
ensure
  @@output = $stdout
end
