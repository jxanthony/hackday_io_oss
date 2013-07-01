require 'spec_helper'

describe "admin_comments/show" do
  before(:each) do
    @admin_comment = assign(:admin_comment, stub_model(AdminComment,
      :user_id => 1,
      :body => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/MyText/)
  end
end
