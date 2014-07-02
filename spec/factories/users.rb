# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, :class => 'Users' do
    image "MyString"
    name "MyString"
    vippredictor_id 1
  end
end
