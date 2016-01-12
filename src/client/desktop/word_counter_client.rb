require 'green_shoes'

REPOSITORIES_RELATIVE_PATH = '../../repositories'

class Client
    def initialize
        @path = 'asd'
        @this = self
        create_window()
    end

    def create_window
        Shoes.app(
            title: '360 No Scope Word Counter',
            width: 600,
            height: 600) do

            stack do
                flow do
                    #stack :width => '33%', :align => 'left' do
                    stack  :width => '30%', :float => 'left' do
                        @path_box = edit_line
                        button 'Browse' do
                            path = ask_open_folder()
                            @path_box.text = path

                        end
                    end

                    stack :width => '60%' do

                    end

                    stack :width => '10%' do
                        button 'Java' do
                            @result.text = exec_counter(REPOSITORIES_RELATIVE_PATH, 'java', 'java', @path_box.text)
                        end
                        button 'C++' do
                            @result.text = exec_counter(REPOSITORIES_RELATIVE_PATH, 'c++', 'cpp', @path_box.text)
                        end
                        button 'Ruby' do
                            @result.text = exec_counter(REPOSITORIES_RELATIVE_PATH, 'ruby', 'rb', @path_box.text)
                        end
                    end
                end

                @result = edit_box :width => '100%', :height => '400px'
                #@result.width = '100%'
                @result.text = "here the result will be shown, after the counting is done"
            end
        end
    end
end

def exec_counter(path, language, format, result_path)
    #return "#{path}/#{language}"
    result = `ruby ../../word_counter/word_counter.rb -d #{path}/#{language} #{format} json #{result_path}`
    svg_dir = result_path.length > 0 ? result_path : '.'
    puts "#{svg_dir}/#{format}.svg"
    `Start firefox #{svg_dir}/#{format}.svg`
    return result
end

Client.new
