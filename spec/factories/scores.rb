# == Schema Information
#
# Table name: scores
#
#  id         :integer          not null, primary key
#  points     :integer
#  position   :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_scores_on_user_id  (user_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :score do
    points 1000
    position 1
    association :user, factory: :user
  end
end
