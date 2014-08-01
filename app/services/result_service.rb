class ResultService

  def initialize(fifa_webservice = FifaWebservice.new)
    @fifa_webservice = fifa_webservice
  end

  def verify_daily_results

    changes = false
    games_array = @fifa_webservice.get_daily_games
    games_array.each do |game_hash|

      game = Game.find_by_webservice_id(game_hash["match_number"])
      status = game_hash["status"]
      goals_home = game_hash["home_team"]["goals"]
      goals_away = game_hash["away_team"]["goals"]


      unless game
        populate_games
        game = Game.find_by_webservice_id(game_hash["match_number"])
      end

      return false unless game

      next if status == Game::STATUS_FUTURE

      if !game.result
        create_game_result(game, goals_home, goals_away)
        changes = true
      end


      if game.status != status
        if game.status == Game::STATUS_FUTURE
          populate_users_predictions(game)
        end
        game.update_attributes!(:status => status)

        changes = true
      end

      result = Result.find_by_game_id(game.id)

      if(result.home_team_goal != goals_home || result.away_team_goal != goals_away)
        result.update_attributes!(:home_team_goal => goals_home, :away_team_goal => goals_away)
        changes = true
      end

    end

    if changes
      calculate_daily_score
    end
  end

  def populate_games
    game_service = GameService.new
    game_service.populate_daily_games
  end

  def create_game_result(game, goals_home, goals_away)
    Result.create!(:game_id => game.id, :home_team_goal => goals_home,:away_team_goal =>  goals_away)
  end

  def calculate_daily_score
    GameScoreService.new().calculate_daily_score
  end


  def populate_users_predictions(game)
    PredictionService.new(game.id).populate_users_predictions
  end

end
