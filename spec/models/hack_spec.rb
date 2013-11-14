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
#  requested_hackers  :integer
#  presentation_index :integer
#  creator_id         :integer
#  upvoted_by         :text             default("'--- []\n'")
#  downvoted_by       :text             default("'--- []\n'")
#  group_number       :integer
#

require 'spec_helper'

describe Hack do
  pending "add some examples to (or delete) #{__FILE__}"
end
