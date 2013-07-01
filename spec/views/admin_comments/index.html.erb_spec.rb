require 'spec_helper'

describe "admin_comments/index" do
  before(:each) do
    assign(:admin_comments, [
      stub_model(AdminComment,
        :user_id => 1,
        :body => "MyText"
      ),
      stub_model(AdminComment,
        :user_id => 1,
        :body => "MyText"
      )
    ])
  end

  it "renders a list of admin_comments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
