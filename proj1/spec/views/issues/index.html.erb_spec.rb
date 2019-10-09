require 'rails_helper'

RSpec.describe "issues/index", type: :view do
  before(:each) do
    assign(:issues, [
      Issue.create!(
        :subject => "Subject",
        :text => "Text"
      ),
      Issue.create!(
        :subject => "Subject",
        :text => "Text"
      )
    ])
  end

  it "renders a list of issues" do
    render
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
    assert_select "tr>td", :text => "Text".to_s, :count => 2
  end
end
