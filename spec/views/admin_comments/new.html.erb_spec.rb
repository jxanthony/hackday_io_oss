require 'spec_helper'

describe "admin_comments/new" do
  before(:each) do
    assign(:admin_comment, stub_model(AdminComment,
      :user_id => 1,
      :body => "MyText"
    ).as_new_record)
  end

  it "renders new admin_comment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_comments_path, "post" do
      assert_select "input#admin_comment_user_id[name=?]", "admin_comment[user_id]"
      assert_select "textarea#admin_comment_body[name=?]", "admin_comment[body]"
    end
  end
end
