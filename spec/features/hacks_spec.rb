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
    click_on("Post")

    page.should have_content("ur hack sux")
  end

  it "should let admins make private comments" do
    test_sign_in
    @hackday.admins << User.last
    visit hack_path(@hack)
    fill_in('comment_body', with: "this hack is the wurst")
    check('comment_private')
    click_on("Post")

    page.should have_content("this hack is the wurst")
    page.should have_css('.private-notice')
  end

  it "should not show private comments to non-admins" do
    test_sign_in
    comment = Fabricate(:comment, hack: @hack, user: User.last, private: true)
    visit hack_path(@hack)

    page.should_not have_content(comment.body)
  end

  it "should indicate comments made by contributors"
  it "should indicate comments made by admins"

  it "should require sign-in for voting" do
    visit hack_path(@hack)
    find(:xpath, "//a/img[@alt='Vote Up']/..").click
    
    page.should have_content("You need to be signed in") 
  end

  it "should let signed-in, non-contributors vote hacks up" do
    test_sign_in
    visit hack_path(@hack)
    find(:xpath, "//a/img[@alt='Vote Up']/..").click

    find('.votes').should have_content("1")
  end

  it "should let signed-in, non-contributors vote hacks down" do
    test_sign_in
    visit hack_path(@hack)
    find(:xpath, "//a/img[@alt='Vote Down']/..").click

    find('.votes').should have_content("-1")
  end

  it "should indicate the user's vote" do
    test_sign_in
    visit hack_path(@hack)
    find(:xpath, "//a/img[@alt='Vote Up']/..").click

    page.should have_css('.voted-up')
  end

  it "should not let contributors vote"

  it "should not let non-contributors muck with a hack" do
    visit hack_path(@hack)

    page.should_not have_css('#hack-enqueue')
    page.should_not have_css('#hack-edit')
  end

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
  
  it "should not let signed-out people add hacks" do
    visit hackday_path(@hackday)

    page.should_not have_content("Add Hack")
  end

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
    find('#hack-edit').click
    find('#hack-delete').click

    current_path.should == hackday_path(@hackday)
    find('.alert.alert-success').text.should have_content("Your hack has been destroyed")
  end

  it "should let contributors add their hack to the presentation queue" do
    visit hack_path(@hack)
    find('#hack-enqueue').click

    current_path.should == hack_path(@hack)
    find('.alert.alert-success').text.should have_content("You have signed up to present your hack")
    
    visit queue_hackday_path(@hackday)

    page.should have_content(@hack.title)  
  end

  it "should let contributors remove their hacks from the presentation queue" do
    @hack.update_attribute(:presentation_index, 2)
    visit hack_path(@hack)
    find('#hack-dequeue').click

    current_path.should == hack_path(@hack)
    find('.alert.alert-success').text.should have_content("You will no longer presenting your hack.")

    visit queue_hackday_path(@hackday)

    page.should_not have_content(@hack.title)
  end
end

describe "admins have super powers" do

  before(:each) do
    test_sign_in
    @current_user = User.first
    @hackday = Fabricate(:hackday)
    @hack = Fabricate(:hack, hackday: @hackday)
    @hackday.admins << @current_user     
  end

  it "should let admins move hacks up in the presentation queue" do
    hack2 = Fabricate(:hack, hackday: @hackday, presentation_index: 1)
    @hack.update_attribute(:presentation_index, 2)
    visit queue_hackday_path(@hackday)
    within('#hack_' + @hack.id.to_s) do
      click_on "Move Up"
    end

    find('.alert.alert-success').text.should have_content("has been moved up")
    page.should have_css('#hacks>:first-child h3', text: @hack.title)
  end

  it "should let admins move hacks down in the presentation queue" do
    hack2 = Fabricate(:hack, hackday: @hackday, presentation_index: 2)
    @hack.update_attribute(:presentation_index, 1)
    visit queue_hackday_path(@hackday)
    within('#hack_' + @hack.id.to_s) do
      click_on "Move Down"
    end

    find('.alert.alert-success').text.should have_content("has been moved down")
    page.should have_css('#hacks>:last-child h3', text: @hack.title)
  end

  it "should let admins mark hacks as having been presented" do
    @hack.update_attribute(:presentation_index, 1)
    visit queue_hackday_path(@hackday)
    within('#hack_' + @hack.id.to_s) do
      click_on "Presentation Completed"
    end

    find('.alert.alert-success').text.should have_content("This hack has been presented")
    page.should_not have_content(@hack.title)
  end

end

