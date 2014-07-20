class GameScoreService

  def initialize()
  end

  def calculate_daily_score
    clean_game_scores

    Game.where.not(status: Game::STATUS_FUTURE).includes(:predictions).each do |game|
      next if game.predictions.size == 0

      User.all.each do |user|

        points = GameScoreCalculator.new(user, game).calculate_game_points

        game.game_scores.create!({
          points: points,
          user_id: user.id
        })
      end
    end
  end

  def clean_game_scores
    GameScore.destroy_all
  end



end
