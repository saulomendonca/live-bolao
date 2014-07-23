class ScoreParser

  def initialize(crawler = VippredictorCrawler.new)
    @crawler = crawler
  end

  def get_scores_hash
    html = @crawler.get_score_html_page
    parse_score_html(html)
  end


  def parse_score_html(html)
    doc = Nokogiri::HTML(html)
    lines =  doc.css('//div.geral_padd/ul.list_palpite_partida/li.palpite_item')
    scores = []

    lines.each do |line|
      scores << parse_line(line)
    end

    return scores
  end

  def parse_line(line_html)
    id = line_html.css("div.float_l")[5].css("a")[0]["href"].gsub(/.*uId=/, "")
    user = User.find_by_vippredictor_id(id)
    position = line_html.css("span.float_l")[0].text.to_i
    points = line_html.css("div.float_l")[4].text.to_i

    return {:user_id => user.id, :points => points, :position => position}
  end


end
