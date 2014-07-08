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

  failure_message do |html|
    text = Nokogiri::HTML(html).css(tag).text
    "expected that #{content}' would be the content of tag '#{tag}' but receive '#{text}'"
  end
end

RSpec::Matchers.define :has_tag_with_property_content do |tag, property, content|
  match do |html|
    Nokogiri::HTML(html).css(tag)[0][property] ==  content
  end
end


RSpec.describe UserParser, :type => :service do

  before do
    @crawler = VippredictorCrawler.new
  end

  it "should find html with list of users" do
    html = @crawler.get_users_html_page

    expect(html).to has_tag('//div.geral_padd/ul.list_palpite_partida/li.palpite_item', :count => 45)
  end

  it "should find html with list of teams" do
    html = @crawler.get_teams_html_page

    expect(html).to has_tag_with_content('//a.font-branca', "STI na Copa 2014( World Cup )")
    expect(html).to has_tag('//table.tbl_palpite//tr')
    expect(html).to has_tag('//td.tbl_palpite-timeA')
    expect(html).to has_tag('//td.tbl_palpite-timeB')
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
