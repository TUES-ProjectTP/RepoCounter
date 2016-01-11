class FolderUtils

  def self.ParseRepos(path)
    # TODO: Implement
    hash = Hash.new()
    hash['github'] = []

    Dir.glob(path + "*").each do |folder|
      folder = folder.split('/').last
      hash[folder] = []
      Dir.glob(path + "#{folder}/*").each do |file|
        links = File.readlines(file)
        links.each {|e| hash[folder].push(e) }
      end
    end
    hash
  end
end
