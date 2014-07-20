class ScoreService

  def initialize(crawler = VippredictorCrawler.new)
    @crawler = crawler
    @parser = ScoreParser.new(@crawler)
  end

  def populate_score
    clean_scores

    scores_hash = @parser.get_scores_hash
    scores_hash.each do |score_hash|
      Score.create!(score_hash)
    end
  end

  def clean_scores
    Score.destroy_all
  end



end
