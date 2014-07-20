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

class Prediction < ActiveRecord::Base
  belongs_to :game
  belongs_to :user


  def is_draw?
    self.home_team_goal ==  self.away_team_goal
  end

  def home_team_winner?
    self.home_team_goal >  self.away_team_goal
  end
end
