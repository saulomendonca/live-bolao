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
  has_many :predictions, dependent: :destroy
  has_many :game_scores

  validates :webservice_id, presence: true
  validates :status, inclusion: { in: ["future", "in progress", "completed"]}
  validates :date, presence: true
  validates :home_team, presence: true
  validates :away_team, presence: true
  validates :weight, numericality: { only_integer: true, greater_than: -1 }

  validate :validates_teams



  STATUS_FUTURE = "future"
  STATUS_COMPLETED = "completed"
  STATUS_IN_PROGRESS = "in progress"

  def home_team_name
    home_team.name if home_team
  end

  def home_team_image
    home_team.image if home_team
  end

  def away_team_name
    away_team.name if away_team
  end

  def away_team_image
    away_team.image if away_team
  end


  def home_team_goal
    return 0 if result.nil?
    result.home_team_goal
  end

  def away_team_goal
    return 0 if result.nil?
    result.away_team_goal
  end


  private

  def validates_teams
    if home_team && away_team && home_team.id.equal?(away_team.id)
      errors.add(:away_team, "Away team should be diferent of Home team")
    end
  end

end
