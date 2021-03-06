require 'rails_helper'

RSpec.describe "issues/new", type: :view do
  before(:each) do
    assign(:issue, Issue.new(
      :subject => "MyString",
      :text => "MyString"
    ))
  end

  it "renders new issue form" do
    render

    assert_select "form[action=?][method=?]", issues_path, "post" do

      assert_select "input[name=?]", "issue[subject]"

      assert_select "input[name=?]", "issue[text]"
    end
  end
end
