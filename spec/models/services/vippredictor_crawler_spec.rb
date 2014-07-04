require 'rails_helper'


RSpec::Matchers.define :has_tag do |tag, options = {}|
  match do |html|
    count = 1
    count = options[:count] if options.has_key? :count

    Nokogiri::HTML(html).css(tag).size >= count
  end
end

RSpec::Matchers.define :has_tag_with_content do |tag, content|
  match do |html|
    Nokogiri::HTML(html).css(tag).text == content
  end
end

RSpec::Matchers.define :has_tag_with_property_content do |tag, property, content|
  match do |html|
    Nokogiri::HTML(html).css(tag)[0][property] ==  content
  end
end


RSpec.describe UserParser, :type => :model do

  before do
    @html = '
      <html>
        <body>
          <div class="geral_padd">
            <ul class="list_palpite_partida">
              <li class="palpite_item">
                  <span style="width: 50px;" class="float_l">1</span>
                  <div style="width: 370px;" class="float_l">
                    <td class="tbl_bolao_td">
                      <a class="ranking_mob_img">
                        <img src="http://vippredictorstorage.blob.core.windows.net/vippredictor-user/min-noimage.jpg" class="tbl_bolao_avatar">
                      </a>
                    </td>
                    <td class="tbl_bolao_td">
                        <a>Saulo</a>
                    </td>
                  </div>
                  <div style="width: 180px;" class="float_l">06/12/2014 10:35:06 </div>

                  <div style="width: 150px; font-size: 18px; font-weight: bold; text-align: center;" class="float_l">
                      <strong>2 x 1</strong>
                  </div>

                  <div style="width: 60px; text-align: center;" class="float_l">120 </div>
                  <div style="width: 60px; text-align: center;" class="float_l">6846 </div>
                <div style="width: 60px; text-align: center;" class="float_l">
                  <a href="/en-US/Prediction/Look/34531?uId=348210">
                    <img src="http://vippredictorstorage.blob.core.windows.net/content-theme-20140619/ico_palpites_bt.png" title="Predictions">
                  </a>
                </div>
                <div class="limpa"></div>
              </li>
              <li class="palpite_item">
                  <span style="width: 50px;" class="float_l">1</span>
                  <div style="width: 370px;" class="float_l">
                    <td class="tbl_bolao_td">
                      <a class="ranking_mob_img">
                        <img src="http://vippredictorstorage.blob.core.windows.net/vippredictor-user/min-noimage.jpg" class="tbl_bolao_avatar">
                      </a>
                    </td>
                    <td class="tbl_bolao_td">
                        <a>Kamilla</a>
                    </td>
                  </div>
                  <div style="width: 180px;" class="float_l">06/12/2014 10:35:06 </div>

                  <div style="width: 150px; font-size: 18px; font-weight: bold; text-align: center;" class="float_l">
                      <strong>2 x 1</strong>
                  </div>

                  <div style="width: 60px; text-align: center;" class="float_l">120 </div>
                  <div style="width: 60px; text-align: center;" class="float_l">6846 </div>
                <div style="width: 60px; text-align: center;" class="float_l">
                  <a href="/en-US/Prediction/Look/34531?uId=348210">
                    <img src="http://vippredictorstorage.blob.core.windows.net/content-theme-20140619/ico_palpites_bt.png" title="Predictions">
                  </a>
                </div>
                <div class="limpa"></div>
              </li>
            </ul>
          </div>
        </body>
      </html>
    '

    @crawler = VippredictorCrawler.new
    # allow(@crawler).to receive(:get_users_html_page).and_return(@html)
  end

  it "should find html with list of users" do
    url = 'http://www.vippredictor.com/en-US/Prediction/Match/34531?matchId=6245'
    html = @crawler.get_users_html_page

    expect(html).to has_tag('//div.geral_padd/ul.list_palpite_partida/li.palpite_item', :count => 45)
  end

  it "should find login form" do
    agent = Mechanize.new
    page = @crawler.get_vip_predictor_main_page(agent)

    expect(page.content).to has_tag_with_property_content('//form', 'action', "/pt-BR/Account")
    expect(page.content).to has_tag('//input#EmailLogin')
    expect(page.content).to has_tag('//input#SenhaLogin')
  end

  it "should can login in vippredictor" do
    agent = Mechanize.new
    page = @crawler.get_vip_predictor_main_page(agent)

    logged_page = @crawler.login_in_vippredictor(page)
    expect(logged_page.content).to has_tag_with_content('//h1.font_19/a.font-branca', "Saulo Mendonça")
  end

  it "should find lines of users" do
  end
end
