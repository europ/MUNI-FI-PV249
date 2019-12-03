require 'sinatra/base'

require 'git'
require 'json'
require 'pry'

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
      repo = File.join(@repositories_dir, params[:owner], params[:repository_name])

      {
        repository: {
          head: `git -C #{repo} rev-parse HEAD`.strip!,
          public_path: File.join(@public_path, params[:owner], params[:repository_name])
        }
      }.to_json
    end

    post '/repositories/:owner/:repository_name' do
      repo = File.join(@public_path, params[:owner], params[:repository_name])

      `git -C #{repo} rev-parse`
      if $?.success?
        status 409
        {
          message: 'Repository already exists'
        }.to_json
      else
        FileUtils.mkdir_p(repo)
        `git -C #{repo} init`
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
