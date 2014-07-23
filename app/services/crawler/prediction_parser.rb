class PredictionParser

  def initialize(crawler = VippredictorCrawler.new, game_id)
    @crawler = crawler
    @game = Game.find(game_id)
  end

  def get_predictions_hash
    html = @crawler.get_user_game_results_html_page(@game.vippredictor_id)
    parse_html(html)
  end


  def parse_html(html)

    doc = Nokogiri::HTML(html)

    teams =  doc.css('//div.list_partida/ul.list_palpite_partida/li.palpite_item/div.palpite_box_partida//a')
    firstTeam = teams[0].text

    home_team_first = (@game.home_team.code_vippredictor == firstTeam)

    predictions = []


    lines = doc.css('//div.geral_padd/ul.list_palpite_partida/li.palpite_item')
    lines.each do |line|
      prediction = parse_line(line, @game.id, home_team_first)
      predictions << prediction
    end

    return predictions
  end

  def parse_line(line_html, game_id, home_team_first)
    id = line_html.css('div.float_l')[5].css('a')[0]["href"].gsub(/.*uId=/,"")
    user = User.find_by_vippredictor_id(id)

    resultTeamA, resultTeamB = line_html.css('div.float_l')[2].css('strong').text.split(" x ")

    if(home_team_first)
      home_team_goal = resultTeamA
      away_team_goal = resultTeamB
    else
      away_team_goal = resultTeamA
      home_team_goal = resultTeamB
    end


    return {
      :home_team_goal => home_team_goal.to_i,
      :away_team_goal => away_team_goal.to_i,
      :user_id => user.id,
      :game_id => game_id
    }
  end


end
