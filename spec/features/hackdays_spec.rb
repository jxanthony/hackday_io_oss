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

end