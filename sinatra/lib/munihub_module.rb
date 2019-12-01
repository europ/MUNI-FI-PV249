require 'yaml'

###############################################################

CONFIG_PATH_DEFAULT = 'munihub_git.yml'
CONFIG_PATH_ENV_VAR = 'MUNIHUB_GIT_CONFIG_FILE'

PUBLIC_PATH_SUFFIX = '/%{relative_path}'

ERROR = 1
ERROR_CONFIG = 2

###############################################################

def error(msg = 'An error occurred.', exitcode = ERROR)
  STDERR.puts("ERROR: #{msg}")
  #exit exitcode
end

def fetch_config
  config = YAML.load(load_config)

  unless config.has_key?(:repositories_dir)
    error("Configuration file does not include 'repositories_dir' key!", ERROR_CONFIG)
  end

  if config.has_key?(:public_path)
    config[:public_path].slice!(PUBLIC_PATH_SUFFIX)

    unless File.directory?(config[:public_path])
      error("Directory specified by 'public_path' does not exist!", ERROR_CONFIG)
    end
  else
    error("Configuration file does not include 'public_path' key!", ERROR_CONFIG)
  end

  config
end

def load_config
  path = ENV.fetch(CONFIG_PATH_ENV_VAR)
  begin
    File.read(path, mode: 'r')
  rescue Errno::ENOENT
    error("File '#{path}' defined by environment variable not found!", ERROR_CONFIG)
  end
rescue KeyError
  begin
    File.read(CONFIG_PATH_DEFAULT, mode: 'r')
  rescue Errno::ENOENT
    error("File '#{CONFIG_PATH_DEFAULT}' defined by default path not found!", ERROR_CONFIG)
  end
end
