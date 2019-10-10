require 'rails_helper'

RSpec.describe "sessions/index", type: :view do
  before(:each) do
    assign(:sessions, [
      Session.create!(
        :new => "New",
        :create => "Create",
        :destroy => "Destroy"
      ),
      Session.create!(
        :new => "New",
        :create => "Create",
        :destroy => "Destroy"
      )
    ])
  end

  it "renders a list of sessions" do
    render
    assert_select "tr>td", :text => "New".to_s, :count => 2
    assert_select "tr>td", :text => "Create".to_s, :count => 2
    assert_select "tr>td", :text => "Destroy".to_s, :count => 2
  end
end
