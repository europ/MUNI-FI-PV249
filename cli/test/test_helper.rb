require 'minitest/autorun'
require 'fileutils'

SUPPORT_DIR = File.expand_path('support', File.dirname(__FILE__))
MUNIHUB_PATH = File.expand_path('../munihub.rb', File.dirname(__FILE__))

REPO_WITHOUT_CONFIG = File.join(SUPPORT_DIR, 'repo_without_config')
REPO_WITH_CONFIG = File.join(SUPPORT_DIR, 'repo_with_config')

FAKE_EDITOR = File.join(SUPPORT_DIR, 'fake_editor.rb')

def init_git_repo(dir)
  @original_pwd = Dir.pwd
  Dir.chdir(dir)
  system('git', 'init')
  system('git', 'add', '-A', '.')
  system('git', 'commit', '-m', 'First commit')
end

def clean_git_repo(dir)
  raise 'Missing @original_pwd, call init_git_repo first' unless @original_pwd
  Dir.chdir(@original_pwd)
  unless File.basename(File.expand_path(dir)) =~ /repo_(with|without)_config/
    raise "unexpected repo #{dir} to clean"
  end
  FileUtils.rm_r(File.join(dir, '.git'))
  system('git', 'checkout', '--', dir)
  system('git', 'clean', '-f', dir)
end

def create_a_branch
  system('git checkout -b mybranch')
end

def add_change
  File.open('README.md', 'a') { |f| f.puts 'new_line' }
end

def commit_changes(subject = "My awesome patch", body = "I can not believe this repo was without it")
  system('git add -A .')
  message = [subject, body].compact.join("\n\n")
  system("git commit -m '#{message}'")
end

def run_munihub(editor_mode = 'sign')
  fake_editor_env = { 'EDITOR' => "#{FAKE_EDITOR} #{editor_mode}" }
  system(fake_editor_env, MUNIHUB_PATH, 'pull-request')
end

def munihub_message
  File.read('.git/MUNIHUB_MESSAGE')
end
