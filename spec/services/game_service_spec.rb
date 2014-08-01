require 'rails_helper'

RSpec.describe GameService, :type => :service do

  before :each do
    # webservice = FifaWebservice.new
    Team.destroy_all
    User.destroy_all
    create(:team, code_fifa: "BRA", code_vippredictor: "BRA", name: "Brazil")
    create(:team, code_fifa: "CRO", code_vippredictor: "CRO", name: "Croatia")

    create(:user)

    @games = [
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

    webservice = double("FifaWebservice")
    allow(webservice).to receive(:get_daily_games).and_return(@games)

    @service = GameService.new(webservice)
  end


  it "should create a game" do
    expect(Game.count).to eq 0
    @service.populate_daily_games
    expect(Game.count).to eq 1
  end

  it "should not create a game two times" do
    expect(Game.count).to eq 0
    @service.populate_daily_games
    expect(Game.count).to eq 1
    @service.populate_daily_games
    expect(Game.count).to eq 1
  end

  it "should create games with correct teams" do
    @service.populate_daily_games
    game = Game.first
    expect(game.home_team.code_fifa).to be_eql "BRA"
    expect(game.away_team.code_fifa).to be_eql "CRO"
  end

  it "should create games with correct status" do
    @service.populate_daily_games
    game = Game.first
    expect(game.status).to be_eql "future"
  end

  it "should create more than one games" do
    @games << {
        "match_number" => 3,
        "location" => "Arena de Sao Paulo",
        "datetime" => "2014-06-12T17:00:00.000-03:00",
        "status" => "future",
        "home_team" => {
          "country" => "Croatia",
          "code" => "CRO",
          "goals" => 0
        },
        "away_team" => {
          "country" => "Brazil",
          "code" => "BRA",
          "goals" => 0
        },
        "winner" => "",
        "winner_code" => "",
        "home_team_events"  => []
      }

    expect(Game.count).to eq 0
    @service.populate_daily_games
    expect(Game.count).to eq 2
  end

  it "should clean games before create the daily games" do
    game = create(:game, away_team: Team.first, home_team: Team.last)
    create(:prediction, game: game, user:User.first)

    2.times do
      create(:game, away_team: Team.first, home_team: Team.last)
    end
    expect(Game.count).to eq 3
    @service.populate_daily_games
    expect(Game.count).to eq 1
    expect(Prediction.count).to eq 0
  end
end
