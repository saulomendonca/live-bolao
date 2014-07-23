# == Schema Information
#
# Table name: games
#
#  id              :integer          not null, primary key
#  webservice_id   :integer
#  vippredictor_id :integer
#  status          :string(255)
#  complete        :boolean
#  weight          :integer
#  date            :date
#  away_team_id    :integer
#  home_team_id    :integer
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_games_on_away_team_id  (away_team_id)
#  index_games_on_home_team_id  (home_team_id)
#

require 'rails_helper'

RSpec.describe Game, :type => :model do
  before do
  end

  it "Should be valid when all attributes is valid" do
    game = build(:game)
    expect(game).to be_valid
  end

  it "Should be not valid when doesn't have home team" do
    game = build(:game, home_team: nil)
    expect(game).not_to be_valid
  end

  it "Should be not valid when doesn't have away team" do
    game = build(:game, away_team: nil)
    expect(game).not_to be_valid
  end

  it "Should be not valid when weight is negative" do
    game = build(:game, weight: -10)
    expect(game).not_to be_valid
  end

  it "Should be not valid when status is 'future'" do
    game = build(:game, status: "future")
    expect(game).to be_valid
  end

  it "Should be not valid when status is 'in progress'" do
    game = build(:game, status: "in progress")
    expect(game).to be_valid
  end

  it "Should be not valid when status is 'completed'" do
    game = build(:game, status: "completed")
    expect(game).to be_valid
  end

  it "Should be not valid when status is diferent of ('future', 'in progress', 'completed')" do
    game = build(:game, status: "breaking")
    expect(game).not_to be_valid
  end

  it "Should be not valid when home team is the same team of away team" do
    game = build(:game, home_team: Team.first, away_team: Team.first)
    expect(game).not_to be_valid
  end







end
