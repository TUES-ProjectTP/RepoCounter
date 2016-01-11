require 'csv'
require 'json'
require 'rexml/document'

module WordCounter
  class Result
    attr_accessor :marks_count, :word_counts

    def initialize(word_list, marks_count)
      @word_counts = word_list
      @marks_count = marks_count
    end

    def to_csv
      CSV.open("result.csv","w") do |csv|
        @word_counts.each do |key, val|
          csv << [key, val]
          puts "#{key},#{val}"
        end
        csv << ["marks", @marks_count] if @marks_count > 0
        puts "\"marks\",#{@marks_count}" if @marks_count > 0
      end
    end

    def to_json
      File.open("result.json", "w") do |file|
        word_format = []
        @word_counts.each { |k, v| word_format.push([k, v]) }
        json_format = {
          "marks" => @marks_count,
          "words" => word_format
        }
        json = JSON.generate(json_format)
        file << json

        json
      end
    end

    def to_xml
      xml = REXML::Document.new

      words_counts_e = xml.add_element("word-counts")
      words_counts_e.add_element("marks").add_text("#{@marks_count}")
      words_xml = words_counts_e.add_element("words")

      @word_counts.each do |key, val|
        word = words_xml.add_element("word")
        word.add_attribute("count", val)
        word.add_text("#{key}")
      end

      output = ''
      xml.write(output, 1)
      File.open("result.xml", "w") { |file| file << output }
      output
    end

    def to_svg
		rect_x = 20
		File.open("B_27_Radostin_Angelov.svg", "w") do
			|file|
				file << '<svg xmlns="http://www.w3.org/2000/svg" width="2000" height="300">'

				max_count = @word_counts[0][1]

				percentage = @marks_count / max_count.to_f
				height = percentage * 200

				@word_counts.each do
				|pair|
					count = pair[1]
					percentage = count / max_count.to_f
					height = percentage * 200

					file << print_rect(rect_x, 205, height, 10)
					file << print_text(rect_x - 7, 208, pair[0])

					rect_x += 10
				end

				file << '</svg>'
		end
	end

    private
    def get_rekt(width, height, x_pos) #lol
      '<rect x="' + x_pos.to_s + '" y="200" width="' + width.to_s + '" height="' + height.to_s + '" stroke="red" fill="black" />' + "\n"
    end
    def get_text(x, y, text)
      x += 3
      '<text fill="green" x="' + x.to_s + '" y="' + y.to_s + '" font-family="Verdana" font-size="10"
      transform="rotate(90, ' + x.to_s + ', ' + y.to_s + ')">' + text + '</text>' + "\n"
    end
  end
end
