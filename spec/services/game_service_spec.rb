require 'rails_helper'

RSpec.describe GameService, :type => :service do

  before do
    # webservice = FifaWebservice.new

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
    # {"match_number":1,"location":"Arena de Sao Paulo","datetime":"2014-06-12T17:00:00.000-03:00","status":"completed","home_team":{"country":"Brazil","code":"BRA","goals":3},"away_team":{"country":"Croatia","code":"CRO","goals":1},"winner":"Brazil","winner_code":"BRA","home_team_events":[{"id":662,"type_of_event":"goal-own","player":"Marcelo","time":"11"},{"id":665,"type_of_event":"yellow-card","player":"Neymar Jr","time":"27"},{"id":666,"type_of_event":"goal","player":"Neymar Jr","time":"29"},{"id":664,"type_of_event":"substitution-out","player":"Paulinho","time":"63"},{"id":672,"type_of_event":"substitution-in","player":"Hernanes","time":"63"},{"id":663,"type_of_event":"substitution-out","player":"Hulk","time":"68"},{"id":673,"type_of_event":"substitution-in","player":"Bernard","time":"68"},{"id":667,"type_of_event":"goal-penalty","player":"Neymar Jr","time":"71"},{"id":670,"type_of_event":"yellow-card","player":"L Gustavo","time":"88"},{"id":668,"type_of_event":"substitution-out","player":"Neymar Jr","time":"88"},{"id":671,"type_of_event":"substitution-in","player":"Ramires","time":"88"},{"id":669,"type_of_event":"goal","player":"Oscar","time":"901"}],"away_team_events":[{"id":677,"type_of_event":"substitution-in","player":"BrozoviĆ","time":"61"},{"id":674,"type_of_event":"yellow-card","player":"Corluka","time":"66"}


    webservice = double("FifaWebservice")
    allow(webservice).to receive(:get_daily_games).and_return(games)

    @service = GameService.new(webservice)
  end


  it "should create a game" do
    expect(Game.count).to eq 0
    @service.populate_daily_games
    expect(Game.count).to eq 1
  end

  it "should not create a game two time" do
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
end
