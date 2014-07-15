class Game < ActiveRecord::Base
  belongs_to :home_team, class_name:Team, foreign_key: "home_team_id"
  belongs_to :away_team, class_name:Team, foreign_key: "away_team_id"
  has_one :result


  STATUS_FUTURE = "future"
  STATUS_COMPLETED = "completed"
  STATUS_IN_PROGRESS = "in progress"

end
