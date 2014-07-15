# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    web_service_id 1
    vippredictor_id 1
    status "MyString"
    complete false
    weight 1
    date "2014-07-08"
    away_team nil
    home_team nil
  end
end
