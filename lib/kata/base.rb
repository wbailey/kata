require 'command_line_reporter'

module Kata
  module Base
    include CommandLineReporter

    @@times = []

    def kata(txt, lib = nil)
      @kata_name = txt
      puts "#{@kata_name} Kata"
      yield if block_given?
      complete
    end

    def context(txt)
      puts indent + txt
      yield if block_given?
    end

    def requirement(txt = 'kata requirement')
      puts indent + txt

      start = Time.now

      yield if block_given?

      rsp = ask "\ncompleted (Y|n): ", 'y'

      puts

      system %Q{git add . && git commit -m '#{txt}' > /dev/null} rescue Exception

      elapsed = Time.now - start
      @@times << {:title => txt, :time => elapsed}

      complete false if rsp.downcase == 'n'
    end

    def example(txt)
      puts indent + '- ' + "example: #{txt}"
    end

    def detail(txt)
      puts indent + '- ' + "detail: #{txt}"
    end

    def questions
      if block_given?
        puts "\nQuestions:"
        yield
      end
    end

    def question(txt)
      puts indent + "- #{txt}"
    end

    private

    def ask(prompt, default)
      print prompt
      $stdin.gets.chomp || default
    end

    def complete(status = true)
      return if @@times.size == 0

      formatter = lambda do |sec|
        use = sec.round
        [use/3600, use/60 % 60, use % 60].map {|v| v.to_s.rjust(2,'0')}.join(':')
      end

      suppress_output

      table :border => true do
        row :header => true do
          column 'Requirement', :color => 'red', :width => 80
          column 'Time', :color => 'red', :width => 8
        end

        @@times.each do |t|
          row do
            column t[:title]
            column formatter.call(t[:time])
          end
        end
      end

      report = capture_output

      File.open('report.txt', 'w').write( report )

      puts report
    end

    def ancestry
      caller.grep(/#{Regexp.escape(__FILE__)}/).map {|v| v.match(/^[^`]*`([^']*)'/)[1]}
    end

    def indent
      nesting = ancestry.size - 2
      ' ' * (3 * nesting)
    end
  end
end

include Kata::Base
