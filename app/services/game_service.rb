class GameService

  def initialize(fifa_webservice = FifaWebservice.new)
    @fifa_webservice = fifa_webservice
  end

  def populate_daily_games
    clean_games

    games_array = @fifa_webservice.get_daily_games
    games_array.each do |jogo|

      webservice_id = jogo["match_number"]
      away_team = Team.find_by_code_fifa(jogo["away_team"]["code"])
      home_team = Team.find_by_code_fifa(jogo["home_team"]["code"])
      weight = GamePontuationTranslate.get_pontuation_by_date(Date.today)
      vippredictor_id  = VippredictorService.get_vippredictor_id(webservice_id)

      if Game.find_by_webservice_id(webservice_id) == nil
        Game.create!(
          :status => jogo["status"],
          :webservice_id => webservice_id,
          :vippredictor_id => vippredictor_id,
          :away_team_id => away_team.id,
          :home_team_id => home_team.id,
          :weight => weight,
          :complete => (jogo["status"] == "completed"),
          :date => jogo["datetime"]
        )
      end
    end
  end

  def clean_games
    Game.destroy_all
  end



end
