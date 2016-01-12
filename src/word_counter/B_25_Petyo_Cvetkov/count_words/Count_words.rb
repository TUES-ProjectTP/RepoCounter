module WordCounter
  class Parser
    def initialize
      @text = " "
    end
    def parse(string)
      result = Result.new
      result.marks_count = string.scan(/[,?!@#$%^&*'""'()=+-]/).count
      words = string.downcase.gsub(/[^a-z0-9\s-]/, ' ').split(' ')

      words.each do |word|
        result.word_counts[word] += 1
      end

      result.word_counts = result.word_counts.sort_by { |word, occur| [-occur, word] }
      result
    end



    def parse_file(filename)
      text = ''

      File.open(filename) do |file|
        file.each_line do |line|
          text += line
        end
      end

      parse text
    end
    def dir_parser(dir)
      if dir[dir.size - 1] != "/"
        dir += "/"
      end
      files = Dir.glob(dir + '*')
      files.each do |filename|
        if File.directory? filename
          dir_parser filename
        else
          if ARGV[2] == 'cpp'
            if File.extname(filename) == ".#{ARGV[2]}"||
              File.extname(filename) == ".c"||
              File.extname(filename) == ".cxx"||
              File.extname(filename) == ".cp"
              File.extname(filename) == ".cc"||
              File.extname(filename) == ".c++"


              puts "hi"
              read filename
            end
          elsif ARGV[2] == "rb"
            if File.extname(filename) == ".#{ARGV[2]}"

              read filename
            end
          elsif ARGV[2] == "java"
            if File.extname(filename) == ".#{ARGV[2]}"

              read filename
            end

          end
        end
      end
      parse(@text)
    end
  end
end
def read filename
  @text += File.read(filename)
  @text += " "

end
