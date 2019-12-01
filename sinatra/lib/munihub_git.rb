require 'sinatra/base'

require 'git'
require 'json'

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

    get '/repositories/:owner/:repository_name' do
      repo = File.join(@public_path, params[:owner], params[:repository_name])
      git = Git.open(repo)

      {
        repository: {
          head: git.object('HEAD^').sha,
          public_path: git.dir.path
        }
      }.to_json
    end

    post '/repositories/:owner/:repository_name' do
      repo = File.join(@public_path, params[:owner], params[:repository_name])
      if File.directory?(repo)
        error 409 do
          {
            message: 'Repository already exists'
          }.to_json
        end
      else
        FileUtils.mkdir_p(repo)
        Git.init(repo)

        {
          message: 'Repository created'
        }.to_json
      end
    end

    get '/repositories/:owner/:repository_name/refs/:ref/files/*:path' do
      # TODO
      {message: "todo"}.to_json
    end

    get '/repositories/:owner/:repository_name/refs/:ref/commits' do
      # TODO
      {message: "todo"}.to_json
    end

  end
end
