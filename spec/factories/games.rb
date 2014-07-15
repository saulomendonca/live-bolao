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
