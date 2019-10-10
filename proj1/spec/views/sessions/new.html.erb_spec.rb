require 'rails_helper'

RSpec.describe "sessions/new", type: :view do
  before(:each) do
    assign(:session, Session.new(
      :new => "MyString",
      :create => "MyString",
      :destroy => "MyString"
    ))
  end

  it "renders new session form" do
    render

    assert_select "form[action=?][method=?]", sessions_path, "post" do

      assert_select "input[name=?]", "session[new]"

      assert_select "input[name=?]", "session[create]"

      assert_select "input[name=?]", "session[destroy]"
    end
  end
end
