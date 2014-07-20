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

class Score < ActiveRecord::Base
  belongs_to :user
end
