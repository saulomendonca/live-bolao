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

class GameScore < ActiveRecord::Base
  belongs_to :game
  belongs_to :user

  validates :points, numericality: { only_integer: true, greater_than: -1 }
  validates :game, presence: true
  validates :user, presence: true



  def prediction
    prediction = Prediction.where(:user_id => user.id, :game_id => game.id).first

    return "#{prediction.home_team_goal}x#{prediction.away_team_goal}" if prediction
    ""
  end


end
