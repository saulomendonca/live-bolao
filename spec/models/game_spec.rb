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
    expect(game).to have(1).error_on(:away_team)
    expect(game.errors_on(:away_team)).to include("Away team should be diferent of Home team")

    expect(game).not_to be_valid
  end

  it "Should return the home team name" do
    game = build(:game, home_team: Team.first, away_team: Team.first)
    expect(game.home_team_name).to eq(Team.first.name)
  end

  it "Should return nil as a name if home team is nil" do
    game = build(:game, home_team: nil)
    expect(game.home_team_name).to eq(nil)
  end


  it "Should return the away team name" do
    game = build(:game, home_team: Team.first, away_team: Team.first)
    expect(game.away_team_name).to eq(Team.first.name)
  end

  it "Should return nil as a name if home team is nil" do
    game = build(:game, away_team: nil)
    expect(game.away_team_name).to eq(nil)
  end

  it "Should return the home team image" do
    team = build(:team, name: "Brazil", code_fifa:"BRA", image:"teste")
    game = build(:game, home_team: team, away_team: team)
    expect(game.home_team_image).to eq(team.image)
  end

  it "Should return nil as a image if home team is nil" do
    game = build(:game, home_team: nil)
    expect(game.home_team_image).to eq(nil)
  end

  it "Should return the away team image" do
    team = build(:team, name: "Brazil", code_fifa:"BRA", image:"teste")
    game = build(:game, home_team: team, away_team: team)
    expect(game.away_team_image).to eq(team.image)
  end

  it "Should return nil as a image if away team is nil" do
    game = build(:game, away_team: nil)
    expect(game.away_team_image).to eq(nil)
  end

  it "Should return home team goal" do
    result = build(:result, home_team_goal: 2)
    home_team = build(:team, name: "Brazila", code_fifa:"BRR", image:"teste")
    away_team = build(:team, name: "Brazila", code_fifa:"BRR", image:"teste")
    game = build(:game, home_team:home_team, away_team:away_team, result: result)
    expect(game.home_team_goal).to eq(2)
  end

  it "Should return 0 as home team goal if the game has no result" do
    game = build(:game, result: nil)
    expect(game.home_team_goal).to eq(0)
  end

  it "Should return away team goal" do
    home_team = build(:team, name: "Brazila", code_fifa:"BRR", image:"teste")
    away_team = build(:team, name: "Brazila", code_fifa:"BRR", image:"teste")
    result = build(:result,  away_team_goal: 3)
    game = build(:game, home_team:home_team, away_team:away_team, result: result)
    expect(game.away_team_goal).to eq(3)
  end

  it "Should return 0 as away team goal if the game has no result" do
    game = build(:game, result: nil)
    expect(game.away_team_goal).to eq(0)
  end








end
