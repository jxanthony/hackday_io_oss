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

    it 'should show number of hacks remaining' do
      hack2 = Fabricate(:hack, hackday: @hackday)
      @hackday.join_queue(@hack)
      @hackday.join_queue(hack2)

      test_sign_in
      visit queue_hackday_path(@hackday)

      page.should have_content('2 hacks queued')
    end

    context 'when admin' do
      before :each do
        test_sign_in
        @hackday.admins << User.last
      end

      it 'should show presentation start button' do
        visit queue_hackday_path(@hackday)

        page.should have_content('Start Presentations')
      end

      it 'should let admin start presentations' do
        visit queue_hackday_path(@hackday)
        click_on 'Start Presentations'

        find('#end-hackday').text.should have_content('End Presentations')
      end
    end

    context 'when plebeian hacker' do
      before :each do
        test_sign_in
      end

      it 'should not show presentation start button' do
        visit queue_hackday_path(@hackday)

        page.should_not have_content('Start Presentations')
      end
    end
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

  describe 'user admin' do
    it 'shows add admin button for existing admin' do
      test_sign_in
      @hackday.admins << User.last
      visit hackday_path(@hackday)

      page.should have_content('Add Judge')
    end

    it 'does not show add admin button for non-judges' do
      test_sign_in
      visit hackday_path(@hackday)

      page.should_not have_content('Add Judge')
    end
  end
end