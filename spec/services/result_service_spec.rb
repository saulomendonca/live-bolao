require 'rails_helper'

RSpec.describe ResultService, :type => :service do

  before do

    create(:game, webservice_id: 25)

    @games = [
      {
        "match_number" => 25,
        "location" => "Arena de Sao Paulo",
        "datetime" => "2014-06-12T17:00:00.000-03:00",
        "status" => "in progress",
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


    # webservice = FifaWebservice.new
    webservice = double("FifaWebservice")
    allow(webservice).to receive(:get_daily_games).and_return(@games)

    @service = ResultService.new(webservice)
  end

  it "should handle populate_daily_games when Game doesn't have game" do
    @games[0]["match_number"] = 21;
    webservice = double("FifaWebservice")
    allow(webservice).to receive(:get_daily_games).and_return(@games)
    service = ResultService.new(webservice)
    expect(service).to receive(:populate_games)
    service.verify_daily_results
  end


  it "should call method create_game_result when Game doesn't have a result" do
    expect(@service).to receive(:create_game_result).and_call_original
    @service.verify_daily_results
  end

  it "should create a result when Game doesn't have a result" do
    expect(Result.count).to eq 0
    @service.verify_daily_results
    expect(Result.count).to eq 1
  end

  it "should not create a result when Game is future" do
    @games[0]["status"] = "future";
    expect(Result.count).to eq 0
    @service.verify_daily_results
    expect(Result.count).to eq 0
  end

  it "should not create a new result when the game has one result" do
    game = create(:game, webservice_id: 21, status: "in progress")
    create(:result, home_team_goal: 0, away_team_goal: 0, game: game)
    @games[0]["match_number"] = "21";

    expect(Result.count).to eq 1
    @service.verify_daily_results
    expect(Result.count).to eq 1
  end

  it "should calculate daily score when create a new result" do
    expect(@service).to receive(:calculate_daily_score)
    @service.verify_daily_results
  end

  it "should not calculate daily score when Game is future" do
    @games[0]["status"] = "future";
    expect(@service).not_to receive(:calculate_daily_score)
    @service.verify_daily_results
  end

  it "should calculate daily score when Game change status from future to in progress" do
    create(:game, webservice_id: 21, status: "future")
    @games[0]["status"] = "in progress";
    @games[0]["match_number"] = "21";

    expect(@service).to receive(:calculate_daily_score)
    expect(@service).to receive(:populate_users_results)
    @service.verify_daily_results
  end

  it "should calculate daily score when Game change status from future to completed" do
    create(:game, webservice_id: 21, status: "future")
    @games[0]["status"] = "completed";
    @games[0]["match_number"] = "21";

    expect(@service).to receive(:calculate_daily_score).and_call_original
    expect(@service).to receive(:populate_users_results).and_call_original
    @service.verify_daily_results
  end


  it "should calculate daily score when Game change status from in progress to completed" do
    create(:game, webservice_id: 21, status: "in progress")
    @games[0]["status"] = "completed";
    @games[0]["match_number"] = "21";

    expect(@service).to receive(:calculate_daily_score).and_call_original
    @service.verify_daily_results
  end

  it "should change status in db when status change in webservice" do
    game = create(:game, webservice_id: 21, status: "in progress")
    @games[0]["status"] = "completed";
    @games[0]["match_number"] = "21";

    @service.verify_daily_results
    expect(Game.find(game.id).status).to be_eql("completed")
  end



  it "should update result when Result change in webservice" do
    game = create(:game, webservice_id: 20, status: "in progress")
    result = create(:result, home_team_goal: 0, away_team_goal: 0, game: game)
    @games[0]["match_number"] = "20";
    @games[0]["home_team"]["goals"] = "3";
    @games[0]["away_team"]["goals"] = "1";
    # @games[0]["status"] = "completed";



    expect(result.home_team_goal).to eq 0
    expect(result.away_team_goal).to eq 0
    @service.verify_daily_results
    expect(Result.find(result.id).home_team_goal).to eq 3
    expect(Result.find(result.id).away_team_goal).to eq 1
  end


  it "should calculate daily score when Result change" do
    game = create(:game, webservice_id: 20, status: "in progress")
    result = create(:result, home_team_goal: 0, away_team_goal: 0, game: game)
    @games[0]["match_number"] = "20";
    @games[0]["home_team"]["goals"] = "3";
    @games[0]["away_team"]["goals"] = "1";
    # @games[0]["status"] = "completed";

    expect(@service).to receive(:calculate_daily_score)
    @service.verify_daily_results
  end



end
