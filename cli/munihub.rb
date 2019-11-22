#!/usr/bin/env ruby

require 'pry'
require 'awesome_print'
require 'optparse'
require 'git'
require 'yaml'
require 'tmpdir'
require 'tempfile'

###############################################################

ERROR = 1
ERROR_OPTION = 2
ERROR_EDITOR = 3

ENV_VAR_EDITOR = 'EDITOR'
FILE_MUNIHUB_MESSAGE = 'MUNIHUB_MESSAGE'

###############################################################

class Error < Exception
  attr_reader :code
  def initialize(msg = 'Error!', code = ERROR)
    @code = code
    super('ERROR: '.concat(msg))
  end
end

###############################################################

class Editor
  def initialize
    @editor = ENV.fetch(ENV_VAR_EDITOR)
    @file = File.join('.git', FILE_MUNIHUB_MESSAGE)
    if File.exist?(@file)
      File.delete(@file)
    end
  rescue KeyError
    raise Error.new("Environment variable '#{ENV_VAR_EDITOR}' is not set!", ERROR_EDITOR)
  end

  def fetch(string)
    write(string)
    edit
    read
  end

  def write(string)
    dir = File.dirname(@file)

    unless File.directory?(dir)
      FileUtils.mkdir_p(dir)
    end

    File.write(@file, string, mode: 'w')
  end

  def read
    if File.file?(@file)
      File.read(@file, mode: 'r')
    else
      raise Error.new("File '#{@file}' does not exist!", ERROR_EDITOR)
    end
  end

  private

  def edit
    unless system("#{@editor} #{@file}")
      raise Error.new("Editor '#{@editor}' failed!", ERROR_EDITOR)
    end
  end
end

###############################################################

class Options
  def self.parse
    if ARGV.shift != 'pull-request'
      error
    else
      if ARGV.length == 2 # -b base_branch
        if ARGV.shift == '-b'
          ARGV.first
        else
          error
        end
      elsif ARGV.length == 0 # no option
        'master'
      else
        error
      end
    end
  end

  def self.error
    help
    raise Error.new('Option error!', ERROR_OPTION)
  end

  def self.help
    print \
      "Usage: munihub.rb pull-request [-b base_branch]\n" \
      "    pull-request   ... mandatory ... action type\n" \
      "    -b base_branch ... optional  ... targeted branch ('master' used as default)\n" \
      "\n"
  end
end

###############################################################

def main

  # branches
  branch_base = Options.parse
  branch_source = `git rev-parse --abbrev-ref HEAD`.strip!

  # commit hashes
  commits = `git cherry #{branch_base} #{branch_source} | cut -c3-`.split("\n")
  if commits.size == 0
    raise Error.new('There is no commit difference!')
  end

  # pull request text
  git = Git.open(Dir.pwd)
  text = String.new
  if commits.size == 1
    text << git.gcommit(commits.first).message
    text << "\n"
  else
    commits.each do |c|
      git.gcommit(c).message.each_line("\n") do |line|
        if line == "\n"
          text << "#\n"
        else
          text << "# "+line.strip+"\n"
        end
      end
      text << "#\n"
    end
    text = text[0..-3]
  end

  # edit pull request text
  editor = Editor.new
  message = editor.fetch(text)
  text = message.each_line.select{ |s| /^[^#].*$/.match(s) }
  raise Error.new('Incorrect pull-request text!') unless text.any?

  #exit 0

  Dir.mktmpdir do |dir|
    tmpgit = Git.clone(Dir.pwd, 'repo', path: dir)

    #######################################################################
    # FIX - this makes source branch available, fetch or pull does not help
    tmpgit.checkout(branch_source)
    tmpgit.checkout(branch_base)
    #######################################################################

    begin
      tmpgit.checkout(branch_base)
      tmpgit.merge(branch_source)
    rescue Git::GitExecuteError
      raise Error.new('Merge error!')
    end

    begin
      yml_content = YAML.load_file(File.join(tmpgit.dir.path, '.munihub.yml'))

      yml_command = yml_content[:test_script]
      raise Error.new('Missing key in \'.munihub.yml\'!') unless yml_command

      retval = system("ruby #{yml_command}", chdir: tmpgit.dir.path)
      raise Error.new("Unsuccessfully executed command '#{yml_command}'!") unless retval
    rescue Errno::ENOENT
      raise Error.new('Missing file \'.munihub.yml\'!')
    end

    text.each { |t| puts t}
  end
end

########################################################################

begin
  main
  exit 0
rescue Error => e
  STDERR.puts(e.message)
  exit e.code
end
