require 'rails_helper'

RSpec.describe "issues/edit", type: :view do
  before(:each) do
    @issue = assign(:issue, Issue.create!(
      :subject => "MyString",
      :text => "MyString"
    ))
  end

  it "renders the edit issue form" do
    render

    assert_select "form[action=?][method=?]", issue_path(@issue), "post" do

      assert_select "input[name=?]", "issue[subject]"

      assert_select "input[name=?]", "issue[text]"
    end
  end
end
