require 'rails_helper'

RSpec.describe GameScoreService, :type => :service do

  before do
    @game = create(:game, status: "completed", away_team: Team.first, home_team: Team.last)
    game2 = create(:game, webservice_id: 2, status: "in progress", away_team: Team.first, home_team: Team.last)
    User.all.each do |user|
      create(:prediction, user: user, game: @game)
      create(:prediction, user: user, game: game2)
    end
    @service = GameScoreService.new()
  end

  it "should clean game scores before calculate game score" do
    3.times do
      create(:game_score, game: @game, user: User.first)
    end
    expect(GameScore.count).to eq 3
    @service.calculate_daily_score
    expect(GameScore.count).to eq 90
  end


  it "should create one game score for each game and each user" do
    expect(GameScore.count).to eq 0
    @service.calculate_daily_score
    expect(GameScore.count).to eq 90
  end

  it "should not create game score for future games" do
    @game.update_attributes!(status: "future")
    expect(GameScore.count).to eq 0
    @service.calculate_daily_score
    expect(GameScore.count).to eq 45
  end

  it "should not create game score for games without predictions" do
    game = create(:game, status: "in progress")
    expect(GameScore.count).to eq 0
    @service.calculate_daily_score
    expect(GameScore.count).to eq 90
  end


end


