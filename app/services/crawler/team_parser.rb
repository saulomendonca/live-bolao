class TeamParser

  def initialize(crawler = VippredictorCrawler.new, fifa_web_service = FifaWebservice.new)
    @crawler = crawler
    @fifa_web_service = fifa_web_service
  end

  def get_teams_hash
    html = @crawler.get_teams_html_page
    parse_teams_html(html)
  end


  def parse_teams_html(html)

    @teams_fifa = @fifa_web_service.get_hash_teams

    doc = Nokogiri::HTML(html)
    lines =  doc.css('//table.tbl_palpite//tr')
    teams = []

    lines.each do |line|
      next if teams.size == 32
      team = parse_line(line)
      teams << team if team && !teams.find{ |t| t[:code_fifa] == team[:code_fifa]}
    end

    return teams
  end

  def parse_line(line_html)
    if line_html.css("td.tbl_palpite-escudo")[0].css("img")[0]

      code_vip = line_html.css("td.tbl_palpite-timeA")[0].css("a").text
      img = line_html.css("td.tbl_palpite-escudo")[0].css("img")[0]["src"]

      team_code = TeamCodeTranslate.get_fifa_code(code_vip)

      team = @teams_fifa.find{ |t| t[:code] == team_code}

      return {:code_fifa => team_code, :code_vippredictor => code_vip, :name => team[:name], :image => img}
    end
  end

end
