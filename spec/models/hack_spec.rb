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

    context '#add_tags' do
      it 'should add tags from array' do
        tags = ['awesome', 'wow']
        @hack.add_tags tags

        @hack.tag_list.should eq ['awesome', 'wow']
      end

      it 'should add tags from string' do
        tags = 'awesome,wow'
        @hack.add_tags tags

        @hack.tag_list.should eq ['awesome', 'wow']
      end
    end

    context '#remove_tags' do
      before :each do
        @hack.tag_list.add ['awesome', 'wow', 'yay']
      end

      it 'removes tags from array' do
        @hack.remove_tags ['awesome', 'yay']

        @hack.tag_list.should eq ['wow']
      end

      it 'removes tags from string' do
        @hack.remove_tags 'awesome, yay'

        @hack.tag_list.should eq ['wow']
      end
    end
  end
end
