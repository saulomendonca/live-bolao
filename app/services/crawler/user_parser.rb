class UserParser

  def initialize(crawler = VippredictorCrawler.new)
    @crawler = crawler
  end

  def get_users_hash
    html = @crawler.get_users_html_page
    parse_users_html(html)
  end


  def parse_users_html(html)
    doc = Nokogiri::HTML(html)
    linhas =  doc.css('//div.geral_padd/ul.list_palpite_partida/li.palpite_item')

    return linhas.map do |linha|
      name =  linha.css("td.tbl_bolao_td").text.gsub("/n", "").strip
      id = linha.css("div.float_l")[5].css("a")[0]["href"].gsub(/.*uId=/, "").to_i
      img = linha.css("div.float_l/td/a/img")[0]["src"]
      {name: name, vippredictor_id: id, image: img}
    end
  end
end
