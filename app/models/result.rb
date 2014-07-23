# == Schema Information
#
# Table name: results
#
#  id             :integer          not null, primary key
#  home_team_goal :integer
#  away_team_goal :integer
#  game_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_results_on_game_id  (game_id)
#

class Result < ActiveRecord::Base
  belongs_to :game

  validates :home_team_goal, numericality: { only_integer: true, greater_than: -1 }
  validates :away_team_goal, numericality: { only_integer: true, greater_than: -1 }
  validates :game, presence: true

  def draw?
    self.home_team_goal ==  self.away_team_goal
  end

  def home_team_winner?
    self.home_team_goal >  self.away_team_goal
  end
end
