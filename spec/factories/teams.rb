# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team, :class => 'Team' do
    code_fifa "BRA"
    code_vippredictor "BRA"
    name "Brazil"
    image "image.png"
  end
end
