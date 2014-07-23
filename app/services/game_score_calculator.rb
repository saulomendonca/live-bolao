class GameScoreCalculator

  def initialize(user, game)
    @user = user
    @game = game
  end

  def calculate_game_points
    @result = @game.result
    @prediction = Prediction.find_by_user_id_and_game_id(@user.id, @game.id)

    return 0 if !@result || !@prediction

    if @result.draw?
      return calculate_points_of_draw
    end
    return calculate_points_of_game_with_winner
  end

  def calculate_points_of_draw
    if @prediction.draw?

      return 25 *  @game.weight if @result.away_team_goal == @prediction.away_team_goal
      return 15 *  @game.weight
    end

    return 0
  end
  def calculate_points_of_game_with_winner
    return 4 *  @game.weight if @prediction.draw?
    return 0 if @result.home_team_winner? !=  @prediction.home_team_winner?

    result_diference = @result.home_team_goal - @result.away_team_goal
    prediction_diference = @prediction.home_team_goal - @prediction.away_team_goal
    diference_of_goals = result_diference == prediction_diference
    if @result.home_team_winner?
      same_winner_goal = @result.home_team_goal == @prediction.home_team_goal
      same_loser_goal = @result.away_team_goal == @prediction.away_team_goal
    else
      same_winner_goal = @result.away_team_goal == @prediction.away_team_goal
      same_loser_goal = @result.home_team_goal == @prediction.home_team_goal
    end


    return 25 *  @game.weight if same_winner_goal && same_loser_goal
    return 18 *  @game.weight if same_winner_goal
    return 15 *  @game.weight if diference_of_goals
    return 12 *  @game.weight if same_loser_goal


    return 10 *  @game.weight
  end


end
