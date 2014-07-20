# == Schema Information
#
# Table name: games
#
#  id              :integer          not null, primary key
#  webservice_id   :integer
#  vippredictor_id :integer
#  status          :string(255)
#  complete        :boolean
#  weight          :integer
#  date            :date
#  away_team_id    :integer
#  home_team_id    :integer
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_games_on_away_team_id  (away_team_id)
#  index_games_on_home_team_id  (home_team_id)
#

class Game < ActiveRecord::Base
  belongs_to :home_team, class_name:Team, foreign_key: "home_team_id"
  belongs_to :away_team, class_name:Team, foreign_key: "away_team_id"
  has_one :result
  has_many :predictions
  has_many :game_scores


  STATUS_FUTURE = "future"
  STATUS_COMPLETED = "completed"
  STATUS_IN_PROGRESS = "in progress"

end
