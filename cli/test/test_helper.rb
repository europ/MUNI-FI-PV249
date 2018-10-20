require 'minitest/autorun'
require 'fileutils'

SUPPORT_DIR = File.expand_path('support', File.dirname(__FILE__))
MUNIHUB_PATH = File.expand_path('../munihub.rb', File.dirname(__FILE__))

REPO_WITHOUT_CONFIG = File.join(SUPPORT_DIR, 'repo_without_config')
REPO_WITH_CONFIG = File.join(SUPPORT_DIR, 'repo_with_config')

FAKE_EDITOR = File.join(SUPPORT_DIR, 'fake_editor.rb')

DEBUG_COMMANDS = ENV['DEBUG_COMMANDS']

def run_cmd(*args)
  puts "# #{args.join(' ')}" if DEBUG_COMMANDS
  IO.popen(args, :err => [:child, :out]) { |io| puts io.read if DEBUG_COMMANDS }
end

def init_git_repo(dir)
  @original_pwd = Dir.pwd
  Dir.chdir(dir)
  run_cmd('git', 'init')
  run_cmd('git', 'add', '-A', '.')
  run_cmd('git', 'commit', '-m', 'First commit')
end

def clean_git_repo(dir)
  raise 'Missing @original_pwd, call init_git_repo first' unless @original_pwd
  Dir.chdir(@original_pwd)
  unless File.basename(File.expand_path(dir)) =~ /repo_(with|without)_config/
    raise "unexpected repo #{dir} to clean"
  end
  FileUtils.rm_r(File.join(dir, '.git'))
  run_cmd('git', 'checkout', '--', dir)
  run_cmd('git', 'clean', '-f', dir)
end

def create_a_branch(branch = 'mybranch')
  run_cmd('git', 'checkout', '-b', branch)
end

def checkout(branch = 'mybranch')
  run_cmd('git', 'checkout', branch)
end

def add_change(line = 'new_line')
  File.open('README.md', 'a') { |f| f.puts line }
end

def commit_changes(subject = "My awesome patch", body = "I can not believe this repo was without it")
  run_cmd('git', 'add', '-A', '.')
  message = [subject, body].compact.join("\n\n")
  run_cmd('git', 'commit', '-m', message)
end

def run_munihub(args: [], editor_mode: 'leave')
  fake_editor_env = { 'EDITOR' => "#{FAKE_EDITOR} #{editor_mode}" }
  command = [MUNIHUB_PATH, 'pull-request'].concat(args)
  puts "# #{command.join(' ')}" if DEBUG_COMMANDS
  message = IO.popen(fake_editor_env, command, :err => [:child, :out], &:read)
  puts message if DEBUG_COMMANDS
  message
end

def munihub_message
  File.read('.git/MUNIHUB_MESSAGE')
end
