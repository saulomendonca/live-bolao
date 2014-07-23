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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :result do
    home_team_goal 0
    away_team_goal 0
    association :game, factory: :game, status: "in progress"
  end
end
