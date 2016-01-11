require_relative './source_control_manager'

class GitHubManager < SourceControlManager
  def download_repository(path, links)
    links.each do |link|
      `git clone #{link} #{path}`
    end
  end
end
