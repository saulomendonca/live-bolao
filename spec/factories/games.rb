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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    webservice_id 1
    vippredictor_id 1
    status "future"
    complete false
    weight 10
    date "2014-07-08"
    association :away_team, factory: :team, code_fifa: "BRA", name: "Brazil"
    association :home_team, factory: :team, code_fifa: "CRO", name: "Croatia"
  end
end
