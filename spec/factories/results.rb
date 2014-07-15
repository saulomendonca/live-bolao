# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :result do
    home_team_goal 0
    away_team_goal 0
    game nil
  end
end
