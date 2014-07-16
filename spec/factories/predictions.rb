# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :prediction do
    home_team_goal 1
    away_team_goal 1
    game nil
    user nil
  end
end
