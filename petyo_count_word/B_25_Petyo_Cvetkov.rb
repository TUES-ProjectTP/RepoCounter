require_relative 'B_25_Petyo_Cvetkov/CountWords'

path = ARGV[0]
format = ARGV[3]

if path == "-d"
  result = WordCounter::parse_dir ARGV[1]
else
  if (path.match('^https?:\/\/.+'))
    result = WordCounter::parse_webpage(path)
  else
    result = WordCounter::parse_file(path)
  end
end

  WordCounter::Draw_graph::draw_graph(result.word_counts,result.marks_count)


if format == 'json'
  File.open("#{ARGV[2]}.json", 'w') { |file| file << result.to_json }
  puts result.to_json
elsif format == 'xml'
  File.open("#{ARGV[2]}.xml", 'w') { |file| file << result.to_xml }
  puts result.to_xml
else
  File.open("#{ARGV[2]}.csv", 'w') { |file| file << result.to_csv }
end
