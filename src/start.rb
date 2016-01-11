require './globals'
require './folder_utils'
require './managers/github_manager'
require './managers/oracle_manager'

repositories = FolderUtils::ParseRepos(Globals::REPOSITORY_FOLDER_PATH);

repositories.each do |source_control|
  current_manager = {}

  case source_control
  when 'github'
    current_manager = GitHubManager.new
  when 'oracle'
    current_manager = OracleManager.new
  else
    current_manager = GitHubManager.new
  end

  repositories[source_control].each do |language|
    current_manager.download_repository(Globals::FILE_EXPORT_PATH, language)
  end

  # use wordCounter's parseFolder method to count all files that end with .java
  # export java.json
  # export java.svg

  # use wordCounter's parseFolder method to count all files that end with .cpp or .cc
  # export cpp.json
  # export cpp.svg

  # use wordCounter's parseFolder method to count all files that end with .rb
  # export ruby.json
  # export ruby.svg
end
