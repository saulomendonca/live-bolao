# == Schema Information
#
# Table name: predictions
#
#  id             :integer          not null, primary key
#  home_team_goal :integer
#  away_team_goal :integer
#  game_id        :integer
#  user_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_predictions_on_game_id  (game_id)
#  index_predictions_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Prediction, :type => :model do
  before do
    @game = create(:game)
    @user = User.first
  end

  it "Should be valid when all attributes is valid" do
    prediction = build(:prediction, game: @game, user: @user)
    expect(prediction).to be_valid
  end

  it "Should be not valid when home_team_goal is less than 0" do
    prediction = build(:prediction, home_team_goal: -1, game: @game, user: @user)
    expect(prediction).not_to be_valid
  end

  it "Should be not valid when away_team_goal is less than 0" do
    prediction = build(:prediction, away_team_goal: -1, game: @game, user: @user)
    expect(prediction).not_to be_valid
  end

  it "Should be not valid when doesn't have game" do
    prediction = build(:prediction, game: nil)
    expect(prediction).not_to be_valid
  end

  it "Should be draw when home_team_goal is equal to away_team_goal" do
    prediction = build(:prediction, home_team_goal: 1, away_team_goal: 1, game: @game, user: @user)
    expect(prediction).to be_draw

    prediction = build(:prediction, home_team_goal: 2, away_team_goal: 1, game: @game, user: @user)
    expect(prediction).not_to be_draw
  end

  it "Should home_team_winner is true when home_team_goal is greater than to away_team_goal" do
    prediction = build(:prediction, home_team_goal: 2, away_team_goal: 1, game: @game, user: @user)
    expect(prediction).to be_home_team_winner

    prediction = build(:prediction, home_team_goal: 1, away_team_goal: 1, game: @game, user: @user)
    expect(prediction).not_to be_home_team_winner
    prediction = build(:prediction, home_team_goal: 1, away_team_goal: 2, game: @game, user: @user)
    expect(prediction).not_to be_home_team_winner
  end
end
