# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  hack_id    :integer
#  body       :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  private    :boolean          default(FALSE)
#

require 'spec_helper'

describe Comment do
  pending "add some examples to (or delete) #{__FILE__}"
end
