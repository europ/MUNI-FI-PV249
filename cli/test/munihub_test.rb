require_relative './test_helper'

describe 'munihub.rb pull-request' do
  describe 'message editing' do
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
        run_munihub
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
        run_munihub
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

    describe 'when the resulting message is empty (when excluding commented lines)' do
      it 'exist with non-zero code and appropriate error message' do
        create_a_branch
        add_change
        commit_changes('First change', 'more to come')
        add_change
        commit_changes('Second change', nil)
        add_change
        message = run_munihub('leave')
        munihub_message.must_equal <<EOF
# First change
#
# more to come
#
# Second change
EOF
        $?.exitstatus.wont_equal 0
        message.must_match(/empty message/)
      end
    end
  end
end
