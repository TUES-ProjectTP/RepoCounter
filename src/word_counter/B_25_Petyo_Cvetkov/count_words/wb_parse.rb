require 'net/http'
require 'sanitize'
require 'openssl'
require 'rbconfig'

is_windows = (RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/)
if(is_windows)
    require_relative './Count_words.rb'
else
    require './B_25_Petyo_Cvetkov/count_words/Count_words'
end


module WordCounter
  class WebpageParser < Parser
    def parse(url)
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)

      if uri.scheme == 'https'
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      result = http.get(uri.request_uri)
      text = Sanitize.fragment(result.body)
      super(text)
    end
  end
end
