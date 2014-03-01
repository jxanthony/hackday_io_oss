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

# These tests make sure adding a hack works properly
describe "adding a hack" do

  before(:each) do
    @hackday = Fabricate(:hackday)
  end  

  it "should let signed-in people add hacks" do
    test_sign_in
    visit hackday_path(@hackday)
    click_on("Add Hack")
    fill_in('hack_title', with: "BEST HACK OF ALL TIME")
    fill_in('hack_description', with: "self explanatory")
    fill_in('hack_url', with: "http://yammer.com")
    click_on("Create your hack!")

    current_path.should == hack_path(Hack.first)
    page.should have_content(@hackday.title)
    page.should have_css('#team img[title="Kevin Davis"]') # name from the auth hash
    find('#hack-title').text.should == "BEST HACK OF ALL TIME"
    find('.hack-details p').text.should == "self explanatory"
    page.should have_css('.hack-details a[href="http://yammer.com"]')
  end
  it "should not let signed-in people add hacks"

end

# These tests make sure the stuff you can do as a contributor work
# eg. editing, deleting, adding contributors
describe "owning a hack" do

  before(:each) do
    test_sign_in
    # FIXME: clean this up - there must be a better way to do current_user
    @current_user = User.first
    @hackday = Fabricate(:hackday)
    @hack = Fabricate(:hack, hackday: @hackday)
    @hack.contributors << @current_user  
  end

  # TODO: would really prefer this model of adding contributors to the one below
  it "should let contributors add others" 
  it "should let people add themselves as contributors" do
    other_hack = Fabricate(:hack, hackday: @hackday)
    visit hack_path(other_hack)
    click_on("Join")

    page.should have_css('#team img[title="Kevin Davis"]')
  end
  it "should indicate that you're a contributor"

  it "should let contributors edit the hack details" do
    visit hack_path(@hack)
    find('#hack-edit').click
    fill_in('hack_title', with: "MOST EDITED HACK OF ALL TIME")
    fill_in('hack_description', with: "description v2")
    fill_in('hack_url', with: "http://cotap.com")
    click_on("Update your hack!")

    current_path.should == hack_path(@hack)
    find('#hack-title').text.should == "MOST EDITED HACK OF ALL TIME"
    find('.hack-details p').text.should == "description v2"
    page.should have_css('.hack-details a[href="http://cotap.com"]')
  end

  it "should let contributors delete the hack" do
    visit hack_path(@hack)
    find('#hack-delete').click

    current_path.should == hackday_path(@hackday)
    find('.alert.alert-success').text.should have_content("Your hack has been destroyed")
  end

  it "should let contributors mark as ready to be presented"
  it "should not let non-contributors mark as ready to be presented"

end

