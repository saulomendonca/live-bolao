require 'rails_helper'

RSpec.describe GameScoreCalculator, :type => :service do

  before do
    @user = User.first
    @game = create(:game, status: "in progress", weight: 10, away_team: Team.first, home_team: Team.last)
    @calculator = GameScoreCalculator.new(@user, @game)

  end

  it "should return 0 if game doesn't have prediction" do
    game = create(:game, status: "in progress", away_team: Team.first, home_team: Team.last)
    result = create(:result, game: game, home_team_goal: 0, away_team_goal: 0)
    points = GameScoreCalculator.new(User.first, game).calculate_game_points
    expect(points).to eq 0
  end

  it "should return 0 if game doesn't have result" do
    user = User.first
    game = create(:game, status: "in progress", away_team: Team.first, home_team: Team.last)
    prediction = create(:prediction, game: game, user: user)

    points = GameScoreCalculator.new(user, game).calculate_game_points
    expect(points).to eq 0
  end

  it "should return 0 if game has status 'future' " do
    game = create(:game, status: "future", away_team: Team.first, home_team: Team.last)

    points = GameScoreCalculator.new(User.first, game).calculate_game_points
    expect(points).to eq 0
  end

  it "should return 200 when getting only the losing team with a weight 20" do
    game = create(:game, status: "in progress", weight: 20, away_team: Team.first, home_team: Team.last)

    user = User.first
    result = create(:result, game: game, home_team_goal: 3, away_team_goal: 1)
    prediction = create(:prediction, game: game, user: user, home_team_goal: 1, away_team_goal: 0)
    points = GameScoreCalculator.new(User.first, game).calculate_game_points
    expect(points).to eq 200
  end



  describe "Predicting that the match will end in a tie" do

    it "should return 250 when getting exactly the right score" do
      result = create(:result, game: @game, home_team_goal: 0, away_team_goal: 0)
      prediction = create(:prediction, game: @game, user: @user, home_team_goal: 0, away_team_goal: 0)

      points = @calculator.calculate_game_points
      expect(points).to eq 250
    end

    it "should return 150 when getting an non-exact tie " do

      user = User.first
      result = create(:result, game: @game, home_team_goal: 1, away_team_goal: 1)
      prediction = create(:prediction, game: @game, user: user, home_team_goal: 0, away_team_goal: 0)
      points = @calculator.calculate_game_points
      expect(points).to eq 150
    end

    it "should return 40 when you prediction on a tie and one of the teams won" do

      user = User.first
      result = create(:result, game: @game, home_team_goal: 1, away_team_goal: 0)
      prediction = create(:prediction, game: @game, user: user, home_team_goal: 0, away_team_goal: 0)
      points = @calculator.calculate_game_points
      expect(points).to eq 40
    end
  end


  describe "Predicting that the match will have a winner" do
    it "should return 250 when getting exactly the right score" do

      user = User.first
      result = create(:result, game: @game, home_team_goal: 1, away_team_goal: 0)
      prediction = create(:prediction, game: @game, user: user, home_team_goal: 1, away_team_goal: 0)
      points = @calculator.calculate_game_points
      expect(points).to eq 250
    end

    it "should return 180 when getting the score from the winning team" do

      user = User.first
      result = create(:result, game: @game, home_team_goal: 2, away_team_goal: 1)
      prediction = create(:prediction, game: @game, user: user, home_team_goal: 2, away_team_goal: 0)
      points = @calculator.calculate_game_points
      expect(points).to eq 180
    end

    it "should return 150 when getting the difference of goals between the winner and the loser" do

      user = User.first
      result = create(:result, game: @game, home_team_goal: 2, away_team_goal: 1)
      prediction = create(:prediction, game: @game, user: user, home_team_goal: 1, away_team_goal: 0)
      points = @calculator.calculate_game_points
      expect(points).to eq 150
    end


    it "should return 120 when getting the score of the losing team" do

      user = User.first
      result = create(:result, game: @game, home_team_goal: 2, away_team_goal: 1)
      prediction = create(:prediction, game: @game, user: user, home_team_goal: 3, away_team_goal: 1)
      points = @calculator.calculate_game_points
      expect(points).to eq 120
    end


    it "should return 100 when getting only the losing team" do

      user = User.first
      result = create(:result, game: @game, home_team_goal: 3, away_team_goal: 1)
      prediction = create(:prediction, game: @game, user: user, home_team_goal: 1, away_team_goal: 0)
      points = @calculator.calculate_game_points
      expect(points).to eq 100
    end
  end

end


