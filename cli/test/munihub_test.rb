require_relative './test_helper'

describe 'munihub.rb pull-request' do
  before do
    init_git_repo(REPO_WITHOUT_CONFIG)
  end

  after do
    clean_git_repo(REPO_WITHOUT_CONFIG)
  end

  describe 'for a branch with single commit' do
    it 'opens editor with text containing the commit message' do
      create_a_branch
      add_change
      commit_changes
      run_munihub('pull-request')
      munihub_message.must_equal <<EOF
My awesome patch

I can not believe this repo was without it
-- edited with fake_editor.rb
EOF
    end
  end

  describe 'for a branch with multiple commits' do
    it 'opens editor with text containing commented out commit messages' do
      create_a_branch
      add_change
      commit_changes('First change', 'more to come')
      add_change
      commit_changes('Second change', nil)
      add_change
      run_munihub('pull-request')
      munihub_message.must_equal <<EOF
# First change
#
# more to come
#
# Second change
-- edited with fake_editor.rb
EOF
    end
  end
end
