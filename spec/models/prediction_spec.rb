# == Schema Information
#
# Table name: predictions
#
#  id             :integer          not null, primary key
#  home_team_goal :integer
#  away_team_goal :integer
#  game_id        :integer
#  user_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_predictions_on_game_id  (game_id)
#  index_predictions_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Prediction, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
