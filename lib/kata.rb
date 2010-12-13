module Kata
  # Allow rspec access
  class << Kata
    @@input = $stdin
    @@output = $stdout
    @@times = []
  end

  def kata txt
    @@output.puts txt
    yield if block_given?
    complete
  end

  def requirement txt
    @@output.puts indent + txt

    start = Time.now

    yield if block_given?

    rsp = ask "\ncontinue (Y|n): ", 'y'

    puts

    elapsed = Time.now - start
    @@times << {:title => txt, :time => elapsed}

    complete false if rsp.downcase == 'n'
  end

  def example txt
    @@output.puts indent + '- ' + txt
  end

  private

  def ask prompt, default
    @@output.print prompt
    @@input.gets.chomp || default
  end

  def complete status = true
    title = status ? 'Congratulations!' : 'You completed the following:'

    formatter = lambda do |sec| 
      use = sec.round
      [use/3600, use/60 % 60, use % 60].map {|v| v.to_s.rjust(2,'0')}.join(':')
    end

    puts "\n\n#{title}"
    puts @@times.inject('') {|s,p| s << "- #{p[:title][0,90].ljust(90, ' ')} #{formatter.call(p[:time]).rjust(10,' ')}\n"}

    exit status
  end

  def ancestry
    caller.grep(/#{Regexp.escape(__FILE__)}/).map {|v| v.match(/^[^`]*`([^']*)'/)[1]}
  end

  def indent
    nesting = ancestry.size - 2
    ' ' * (3 * nesting)
  end
end

include Kata
