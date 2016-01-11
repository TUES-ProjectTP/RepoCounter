class FolderUtils

  def self.ParseRepos(path)
    # TODO: Implement
    hash = Hash.new()
    hash['github'] = []
    hash['github'].push('https://github.com/radostin-angelov/ITTales.git')

    return hash
  end
end
