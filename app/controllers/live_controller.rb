class LiveController < ApplicationController

  layout "vippredictor"
  # GET /live
  def index
    result_service = ResultService.new()
    result_service.verify_daily_results

    @live_games = Game.where(:status => "in progress")

    ranking = RankingServiceObject.new()
    @ranking_items = ranking.get_sorted_items
  end

end
