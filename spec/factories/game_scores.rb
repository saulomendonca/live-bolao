# == Schema Information
#
# Table name: game_scores
#
#  id         :integer          not null, primary key
#  points     :integer
#  game_id    :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_game_scores_on_game_id  (game_id)
#  index_game_scores_on_user_id  (user_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game_score do
    points 100
    game nil
    user nil
  end
end
