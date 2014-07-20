# == Schema Information
#
# Table name: game_scores
#
#  id         :integer          not null, primary key
#  points     :integer
#  game_id    :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_game_scores_on_game_id  (game_id)
#  index_game_scores_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe GameScore, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
