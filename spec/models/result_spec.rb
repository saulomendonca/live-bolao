# == Schema Information
#
# Table name: results
#
#  id             :integer          not null, primary key
#  home_team_goal :integer
#  away_team_goal :integer
#  game_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_results_on_game_id  (game_id)
#

require 'rails_helper'

RSpec.describe Result, :type => :model do
  before do
    @game = create(:game, status: "in progress")
  end

  it "Should be valid when all attributes is valid" do
    result = build(:result, game: @game)
    expect(result).to be_valid
  end

  it "Should be not valid when home_team_goal is less than 0" do
    result = build(:result, home_team_goal: -1, game: @game)
    expect(result).not_to be_valid
  end

  it "Should be not valid when away_team_goal is less than 0" do
    result = build(:result, away_team_goal: -1, game: @game)
    expect(result).not_to be_valid
  end

  it "Should be not valid when doesn't have game" do
    result = build(:result, game: nil)
    expect(result).not_to be_valid
  end

  it "Should be draw when home_team_goal is equal to away_team_goal" do
    result = build(:result, home_team_goal: 1, away_team_goal: 1, game: @game)
    expect(result).to be_draw

    result = build(:result, home_team_goal: 2, away_team_goal: 1, game: @game)
    expect(result).not_to be_draw
  end

  it "Should home_team_winner is true when home_team_goal is greater than to away_team_goal" do
    result = build(:result, home_team_goal: 2, away_team_goal: 1, game: @game)
    expect(result).to be_home_team_winner

    result = build(:result, home_team_goal: 1, away_team_goal: 1, game: @game)
    expect(result).not_to be_home_team_winner
    result = build(:result, home_team_goal: 1, away_team_goal: 2, game: @game)
    expect(result).not_to be_home_team_winner
  end
end
