require 'minitest/autorun'
require 'fileutils'

SUPPORT_DIR = File.expand_path('../support', __FILE__)

REPO_WITHOUT_CONFIG = File.join(SUPPORT_DIR, 'repo_without_config')
REPO_WITH_CONFIG = File.join(SUPPORT_DIR, 'repo_with_config')

def init_git_repo(dir)
  Dir.chdir(dir)
  system('git init')
end

def clean_git_repo(dir)
  unless File.basename(File.expand_path(dir)) =~ /repo_(with|without)_config/
    raise "unexpected repo #{dir} to clean"
  end
  File.rm_r(File.join(dir, '.git'))
  system('git checkout --', dir)
end
