# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team, :class => 'Teams' do
    code_fifa "MyString"
    code_vippredictor "MyString"
    name "MyString"
    image "MyString"
  end
end
