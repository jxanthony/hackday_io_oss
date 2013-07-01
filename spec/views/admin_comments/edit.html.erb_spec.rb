require 'spec_helper'

describe "admin_comments/edit" do
  before(:each) do
    @admin_comment = assign(:admin_comment, stub_model(AdminComment,
      :user_id => 1,
      :body => "MyText"
    ))
  end

  it "renders the edit admin_comment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_comment_path(@admin_comment), "post" do
      assert_select "input#admin_comment_user_id[name=?]", "admin_comment[user_id]"
      assert_select "textarea#admin_comment_body[name=?]", "admin_comment[body]"
    end
  end
end
