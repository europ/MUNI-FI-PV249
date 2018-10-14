require_relative './test_helper'

describe 'munihub.rb pull-request' do
  describe 'for a branch with single commit' do
    before do
      init_git_repo(REPO_WITHOUT_CONFIG)
    end

    after do
      clean_git_repo(REPO_WITHOUT_CONFIG)
    end

    it 'opens editor with text containing the commit message' do
      system('git checkout -b mybranch')
      File.write('my_file', 'content of my file')
      system('git add -A .')
      system("git commit -m 'My awesome patch\n\nI can not believe this repo was without it'")
      run_munihub('pull-request')
      munihub_message.must_equal <<EOF
My awesome patch

I can not believe this repo was without it
-- edited with fake_editor.rb
EOF
    end
  end
end
