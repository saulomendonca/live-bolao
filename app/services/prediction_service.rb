class PredictionService

  def initialize(game_id, crawler = VippredictorCrawler.new)
    @crawler = crawler
    @game_id = game_id
    @parser = PredictionParser.new(@crawler, @game_id)
  end

  def populate_users_predictions
    @game = Game.find(@game_id)

    return false if @game.status == Game::STATUS_FUTURE

    predictions_hash = @parser.get_predictions_hash
    predictions_hash.each do |prediction_hash|
      Prediction.create!(prediction_hash)
    end
  end

end
