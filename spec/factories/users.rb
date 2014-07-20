# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  image           :string(255)
#  name            :string(255)
#  vippredictor_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    image "MyString"
    name "MyString"
    vippredictor_id 1
  end
end
