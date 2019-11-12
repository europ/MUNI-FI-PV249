#!/usr/bin/env ruby

require 'pry'
require 'awesome_print'
require 'git'
require 'tempfile'

class Editor
  def initialize
    begin
      @editor = ENV.fetch('EDITOR')
    rescue KeyError
      raise Exception.new('Environment variable \'EDITOR\' is not set!')
    end
  end

  def load(text)
    file = Tempfile.new
    begin
      write(file, text)
      retval = system("#{@editor} #{file.path}")
      if retval == true
        data = read(file)
      else
        raise Exception.new('Editor error!')
      end
    ensure
      file.close
      file.unlink
    end
  end

  def write(file, string)
    file.write(string)
    file.rewind
  end

  def read(file)
    file.rewind
    file.read
  end
end

class Options
  def self.parse
    if ARGV.first != 'pull-request'
      error
    else
      ARGV.shift
      if ARGV.length == 2 # -b base_branch
        if ARGV.first == '-b'
          ARGV.shift
          return ARGV.first
        else
          error
        end
      elsif ARGV.length == 0 # no option
        return 'master'
      else
        error
      end
    end
  end

  def self.error
    help
    raise Exception.new('Argument error!')
  end

  def self.help
    print \
    "Usage: munihub.rb pull-request [-b base_branch]\n" \
    "    pull-request   ... mandatory ... action type\n" \
    "    -b base_branch ... optional  ... targeted branch ('master' used as default)\n" \
    "\n"
  end
end

########################################################################

branch_base = Options.parse

repo_path = `git rev-parse --show-toplevel`.strip!
git = Git.open(repo_path)

branch_source = git.branch.name
branch_source = 'pr' # REMOVE

commits = `git cherry #{branch_base} #{branch_source} | cut -c3-`.split("\n") # possible backtick attack

text = String.new
text << "# ===============================================\n"
commits.each do |c|
  text << "# commit #{c}\n"
  git.gcommit(c).message.split("\n").each do |line|
    text << "# #{line}\n"
  end
  text << "# ===============================================\n"
end

editor = Editor.new
message = editor.load(text)

retval = message.split("\n").any? { |line| line.start_with?(/^[^#].*$/) }
raise Exception.new('Incorrect pull-request text!') unless retval

ap message

puts message

puts "\nSUCCESS"

exit 0
