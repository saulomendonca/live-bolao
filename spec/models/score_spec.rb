# == Schema Information
#
# Table name: scores
#
#  id         :integer          not null, primary key
#  points     :integer
#  position   :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_scores_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Score, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
