# == Schema Information
#
# Table name: global_configurations
#
#  id                       :integer          not null, primary key
#  presentation_in_progress :boolean
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  group_numbers            :text
#

require 'spec_helper'

describe GlobalConfiguration do
  pending "add some examples to (or delete) #{__FILE__}"
end
