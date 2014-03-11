require 'spec_helper'

# These tests make sure displaying a hackday works properly
describe "browsing hackdays" do

  before(:each) do
    @hackday = Fabricate(:hackday)
    @hack = Fabricate(:hack, hackday: @hackday)
  end

  describe "top view" do
    it "should order the hacks by votes" do
      best_hack = Fabricate(:hack, votes: 1000, title: "BEST HACK", hackday: @hackday)
      @hack.votes = 100
      worst_hack = Fabricate(:hack, votes: 0, title: "WORST HACK", hackday: @hackday)

      visit hackday_path(@hackday)
      page.body.index(best_hack.title).should < page.body.index(@hack.title)
      page.body.index(worst_hack.title).should > page.body.index(@hack.title)
    end

    it "should only show hacks from this hackday" do
      alt_hackday = Fabricate(:hackday)
      alt_hack = Fabricate(:hack, hackday: alt_hackday, title: "evil hack")

      visit hackday_path(@hackday)
      page.should have_content(@hack.title)
      page.should_not have_content(alt_hack.title)
    end
  end

  describe "presentation queue" do
    it "should show only the hacks that are ready to present"
  end

  describe "judges comments" do
    it "appears for judges" do
      test_sign_in
      @hackday.admins << User.last
      visit hackday_path(@hackday)

      page.should have_content("Judges Comments")
    end

    it "doesn't appear for non-judges" do
      visit hackday_path(@hackday)

      page.should_not have_content("Judges Comments")

      test_sign_in
      visit hackday_path(@hackday)

      page.should_not have_content("Judges Comments")
    end

    it "should only show private commments" do
      test_sign_in
      @hackday.admins << User.last
      comment = Fabricate(:comment, body: 'public comment', user: User.first, hack: @hack)
      private_comment = Fabricate(:comment, private: true, body: 'private comment', user: User.first, hack: @hack)

      visit judges_hackday_path(@hackday)
      page.should have_content('private comment')
      page.should_not have_content('public comment')
    end

  end

end