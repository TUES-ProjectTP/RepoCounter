require_relative './source_control_manager'

class GitHubManager < SourceControlManager
  def download_repository(path, link)
    `git clone #{link} #{path}`
  end
end
