require 'spec_helper'

# These tests make sure displaying a hack works properly
describe "watching a hack" do

  before(:each) do
    @hackday = Fabricate(:hackday)
    @hack = Fabricate(:hack, hackday: @hackday)
  end

  it "should display the contributors" do
    visit hack_path(@hack)
    find('#team').should have_css('.user-mugshot', count: 3)
  end

  it "should let contributors add others"
  it "should indicate that you're a contributor"
  it "should let contributors edit the hack details"
  it "should let contributors mark as ready to be presented"
  it "should not let non-contributors mark as ready to be presented"

  it "should let signed-in people comment" do
    test_sign_in
    visit hack_path(@hack)
    fill_in('comment_body', with: "ur hack sux")
    click_on("Post Comment")

    page.should have_content("ur hack sux")
  end

  it "should indicate comments made by contributors"
  it "should indicate comments made by admins"

  it "should require sign-in for voting" do
    visit hack_path(@hack)
    find(:xpath, "//a/img[@alt='Vote Up']/..").click
    
    page.should have_content("You have to sign in") 
  end

  it "should let signed-in, non-contributors vote" do
    test_sign_in
    visit hack_path(@hack)
    find(:xpath, "//a/img[@alt='Vote Up']/..").click

    find('.votes').should have_content("1")
  end
  it "should not let contributors vote"
end