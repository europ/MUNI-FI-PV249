require 'git'
require 'json'
require 'sinatra/base'

require_relative './munihub_module'

module MunihubGit
  class App < Sinatra::Base
    attr_reader :config, :repositories_dir, :public_path
    def initialize
      @config ||= fetch_config
      @repositories_dir ||= config[:repositories_dir]
      @public_path ||= config[:public_path]

      super
    end

    # 1st endpoint
    get '/repositories/:owner/:repository_name' do
      repo = File.join(@repositories_dir, params[:owner], params[:repository_name])

      {
        repository: {
          head: `git -C #{repo} rev-parse HEAD`.strip!,
          public_path: File.join(@public_path, params[:owner], params[:repository_name])
        }
      }.to_json
    end

    # 2nd endpoint
    post '/repositories/:owner/:repository_name' do
      repo = File.join(@public_path, params[:owner], params[:repository_name])

      if File.directory?(File.join(repo, ".git"))
        status 409
        {
          message: 'Repository already exists'
        }.to_json
      else
        FileUtils.rm_rf(repo)
        FileUtils.mkdir_p(repo)
        `git init #{repo} --bare`

        {
          message: 'Repository created'
        }.to_json
      end
    end

    # 3rd endpoint
    get '/repositories/:owner/:repository_name/refs/:ref/files/*:path?' do
      repo = File.join(@public_path, params[:owner], params[:repository_name])

      retval = {
        files: []
      }

      data = `git -C #{repo} ls-tree #{params[:ref]} #{params[:splat].first}`
      data.each_line do |line|
        values = line.strip.split(/\s/)
        retval[:files] << {
          name: values[3].gsub(params[:splat].first, ""),
          type: values[1] == "blob" ? "file" : "dir"
        }
      end

      retval.to_json
    end

    # 4th endpoint
    get '/repositories/:owner/:repository_name/refs/:ref/commits' do
      repo = File.join(@public_path, params[:owner], params[:repository_name])

      retval = {
        commits: []
      }

      data = `git -C #{repo} log #{params[:ref]} --pretty=format:'%H:%ae:%s'`

      data.each_line do |line|
        values = line.strip.split(':')
        retval[:commits] << {
          sha: values[0],
          author: values[1],
          subject: values[2]
        }
      end

      retval.to_json
    end
  end
end
