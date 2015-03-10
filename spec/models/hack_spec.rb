# == Schema Information
#
# Table name: hacks
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  description        :text(255)
#  votes              :integer          default(0)
#  url                :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  presentation_index :integer
#  upvoted_by         :text             default("'")
#  downvoted_by       :text             default("'")
#  hackday_id         :integer
#

require 'spec_helper'

describe Hack do

  it "should require a title and description"
  it "should handle voting with dignity and grace"

  describe 'tagging behaviour' do
    before :each do
      @hack = Fabricate(:hack)
    end

    context '#add_tag' do
      it 'should add a new tag' do
        @hack.add_tag 'awesome'

        @hack.tag_list.should eq ['awesome']
      end
    end

    context '#remove_tag' do
      before :each do
        @hack.tag_list.add 'awesome'
      end

      it 'removes a single tag' do
        @hack.remove_tag 'awesome'

        @hack.tag_list.should be_empty
      end
    end
  end
end
