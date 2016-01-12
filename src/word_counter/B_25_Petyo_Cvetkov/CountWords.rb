require 'rbconfig'
is_windows = (RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/)

if (is_windows)
    require_relative 'count_words/write.rb'
    require_relative 'count_words/wb_parse'
    require_relative 'count_words/Count_words'
    require_relative 'count_words/make_graph'

else
    require_relative './B_25_Petyo_Cvetkov/count_words/write'
    require_relative './B_25_Petyo_Cvetkov/count_words/wb_parse'
    require_relative './B_25_Petyo_Cvetkov/count_words/Count_words'
    require_relative './B_25_Petyo_Cvetkov/count_words/make_graph'

end

module WordCounter
  def self.parse(text)
      Parser.new.parse(text)
    end

    def self.parse_file(filepath)
      Parser.new.parse_file(filepath)
    end

    def self.parse_webpage(url)
      WebpageParser.new.parse(url)
    end
    def self.parse_dir(dir)
      Parser.new.dir_parser(dir)
    end

end
