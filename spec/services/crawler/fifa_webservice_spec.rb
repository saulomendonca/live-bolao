require 'rails_helper'

RSpec.describe FifaWebservice, :type => :service do

  before do
    @webservice = FifaWebservice.new()
    json = File.read("./spec/helpers/teams.json")
    allow(@webservice).to receive(:get_json).with('/teams').and_return(json.to_s)

  end

  # Team
  it "should find an Array of Hash of teams" do
    hash = @webservice.get_hash_teams
    expect(hash).to be_a_kind_of(Array)
    expect(hash[0]).to be_a_kind_of(Hash)
  end

  it "get_hash_teams should search in URL '/teams' " do
    expect(@webservice).to receive(:get_json).with("/teams")
    @webservice.get_hash_teams
  end

  it "should get all teams" do
    hash = @webservice.get_hash_teams
    expect(hash.size).to be_eql 24
  end

  it "should generate a hash of teams with code and name" do
    hash = @webservice.get_hash_teams

    expect(hash[0]).to have_key :code
    expect(hash[0]).to have_key :name
  end


  # Games

  it "get_daily_games should search in URL '/matches/today' " do
    expect(@webservice).to receive(:get_json).with("/matches/today").and_return([].to_json)
    hash = @webservice.get_daily_games
  end

  it "should return a Array of Hash of Games" do
    games = [
      {
        "match_number" => 1,
        "location" => "Arena de Sao Paulo",
        "datetime" => "2014-06-12T17:00:00.000-03:00",
        "status" => "future",
        "home_team" => {
          "country" => "Brazil",
          "code" => "BRA",
          "goals" => 0
        },
        "away_team" => {
          "country" => "Croatia",
          "code" => "CRO",
          "goals" => 0
        },
        "winner" => "",
        "winner_code" => "",
        "home_team_events"  => []
      }
    ]

    webservice = FifaWebservice.new()
    allow(webservice).to receive(:get_json).with("/matches/today").and_return(games.to_json)

    hash = webservice.get_daily_games
    expect(hash).to be_a_kind_of(Array)
    expect(hash[0]).to be_a_kind_of(Hash)
  end

end
