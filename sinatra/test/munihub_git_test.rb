require_relative './test_helper'

describe MunihubGit::App do
  include Rack::Test::Methods

  def app
    MunihubGit::App.new
  end

  describe 'get repository details' do
    it 'returns the details of the repository' do
      get "/repositories/#{SAMPLE_REPO}"
      last_response.status.must_equal 200
      response = JSON.parse(last_response.body)
      response['repository']['public_path'].must_include(REPOSITORIES_DIR)
      response['repository']['public_path'].must_include(SAMPLE_REPO)
      response['repository']['head'].must_match(/\w{6}/)
    end
  end

  describe 'create new repository' do
    it 'succeeds when the repository was not there before' do
      new_repo = 'new_owner/new_repo'
      post "/repositories/#{new_repo}"
      last_response.status.must_equal 200
      response = JSON.parse(last_response.body)
      response['message'].must_equal 'Repository created'
      get "/repositories/#{new_repo}"
      response = JSON.parse(last_response.body)
      response['repository']['public_path'].must_include(new_repo)
    end

    it 'fails when the repository has been already created' do
      post "/repositories/#{SAMPLE_REPO}"
      last_response.status.must_equal 409
      response = JSON.parse(last_response.body)
      response['message'].must_equal 'Repository already exists'
    end
  end

  describe 'show repository files' do
    it 'shows files in root dir of master branch' do
      get "/repositories/#{SAMPLE_REPO}/refs/master/files/"
      response = JSON.parse(last_response.body)
      response['files'].must_include('name' => 'README.md', 'type' => 'file')
      response['files'].must_include('name' => 'lib', 'type' => 'dir')
    end

    it 'shows files in subdir of master branch' do
      get "/repositories/#{SAMPLE_REPO}/refs/master/files/lib/"
      response = JSON.parse(last_response.body)
      response['files'].must_include('name' => 'hello_world.rb', 'type' => 'file')
    end

    it 'shows files in subdir of non-master branch' do
      get "/repositories/#{SAMPLE_REPO}/refs/my_branch/files/test/"
      response = JSON.parse(last_response.body)
      response['files'].must_include('name' => 'hello_world_test.rb', 'type' => 'file')
    end
  end

  describe 'show log' do
    it 'shows commits of master branch' do
      get "/repositories/#{SAMPLE_REPO}/refs/master/commits"
      response = JSON.parse(last_response.body)
      response['commits'].map { |c| [c['author'], c['subject']] }.
        must_equal [["testuser@example.com", "Second commit"],
                    ["testuser@example.com", "First commit"]]
    end

    it 'shows commits of non-master branch' do
      get "/repositories/#{SAMPLE_REPO}/refs/my_branch/commits"
      response = JSON.parse(last_response.body)
      response['commits'].map { |c| [c['author'], c['subject']] }.
        must_equal [["testuser@example.com", "Third commit"],
                    ["testuser@example.com", "Second commit"],
                    ["testuser@example.com", "First commit"]]
    end
  end
end
