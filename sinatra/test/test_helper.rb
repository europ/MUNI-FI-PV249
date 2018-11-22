require 'minitest/autorun'
require 'fileutils'
require 'rack/test'
require 'tmpdir'
require 'yaml'

$LOAD_PATH.unshift(File.expand_path('../lib', __dir__))
require 'munihub_git'

SUPPORT_DIR = File.expand_path('support', __dir__)
ROOT_DIR = File.expand_path('..', __dir__)
REPOSITORIES_DIR = File.join(SUPPORT_DIR, 'repositories')
SAMPLE_REPO = 'my_owner/my_repo'
DEBUG_COMMANDS = ENV['DEBUG_COMMANDS']

def run_cmd(*args)
  puts "# #{args.join(' ')}" if DEBUG_COMMANDS
  IO.popen(args, :err => [:child, :out]) do |io|
    msg = io.read
    puts msg if DEBUG_COMMANDS
  end
end

def init_config
  config_file = File.join(REPOSITORIES_DIR, 'munihub_git.yml')
  config = { repositories_dir: REPOSITORIES_DIR,
             public_path: "#{REPOSITORIES_DIR}/%{relative_path}" }
  File.write(config_file, YAML.dump(config))
  ENV['MUNIHUB_GIT_CONFIG_FILE'] = config_file
end

# rubocop:disable Metrics/MethodLength,Metrics/AbcSize
def init_git_repo(dir)
  FileUtils.mkdir_p(dir)
  Dir.chdir(dir) do
    run_cmd('git', 'init', '--bare')
  end
  Dir.mktmpdir do |tmpdir|
    run_cmd('git', 'clone', dir, tmpdir)
    Dir.chdir(tmpdir) do
      run_cmd('git', 'config', 'user.email', 'testuser@example.com')
      run_cmd('git', 'config', 'user.name', 'Test User')
      File.write('README.md', 'Hello World')
      run_cmd('git', 'add', '-A', '.')
      run_cmd('git', 'commit', '-m', 'First commit')

      Dir.mkdir('lib')
      File.write('lib/hello_world.rb', 'echo "Hello World"')
      run_cmd('git', 'add', '-A', '.')
      run_cmd('git', 'commit', '-m', 'Second commit')

      run_cmd('git', 'checkout', '-b', 'my_branch')
      Dir.mkdir('test')
      File.write('test/hello_world_test.rb', 'require "minitest/autorun')
      run_cmd('git', 'add', '-A', '.')
      run_cmd('git', 'commit', '-m', 'Third commit')

      run_cmd('git', 'push', 'origin', '--all')
    end
  end
end
# rubocop:enable Metrics/MethodLength,Metrics/AbcSize

def clean_repositories_dir
  Dir[File.join(REPOSITORIES_DIR, '*')].each { |f| FileUtils.rm_r(f) }
end

clean_repositories_dir
init_config
init_git_repo(File.join(REPOSITORIES_DIR, SAMPLE_REPO))
Minitest.after_run { clean_repositories_dir }
