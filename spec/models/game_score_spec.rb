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

require 'rails_helper'

RSpec.describe GameScore, :type => :model do
  before do
    @game = create(:game)
    @user = User.first
  end

  it "Should be valid when all attributes is valid" do
    game_score = build(:game_score, game: @game, user: @user)
    expect(game_score).to be_valid
  end

  it "Should be not valid when away_team_goal is less than 0" do
    game_score = build(:game_score, points: -1, game: @game, user: @user)
    expect(game_score).not_to be_valid
  end

  it "Should be not valid when doesn't have game" do
    game_score = build(:game_score, points: 0, game: nil, user: @user)
    expect(game_score).not_to be_valid
  end

  it "Should be not valid when doesn't have user" do
    game_score = build(:game_score, points: 0, game: @game, user: nil)
    expect(game_score).not_to be_valid
  end
end
