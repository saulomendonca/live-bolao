require 'rails_helper'

RSpec.describe TeamParser, :type => :service do

  before do
    crawler = VippredictorCrawler.new
    # doc = crawler.get_teams_html_page
    # file = File.open("/Users/saulomendonca/Documents/desenvolvimento/projetos/live-vippredictor/spec/helper/team.html", "w")
    # file.puts doc.force_encoding('ISO-8859-1')

    @html = open("/Users/saulomendonca/Documents/desenvolvimento/projetos/live-vippredictor/spec/helper/team.html")

    crawler = double("VippredictorCrawler")
    allow(crawler).to receive(:get_teams_html_page).and_return(@html)


    webservice = FifaWebservice.new

    @parser = TeamParser.new(crawler, webservice)
  end


  it "should find an Array of Hash" do
    hash = @parser.get_teams_hash
    expect(hash).to be_a_kind_of(Array)
    expect(hash[0]).to be_a_kind_of(Hash)
  end

  it "should generate a hash with team structury" do
    hash = @parser.get_teams_hash

    expect(hash[0]).to have_key :code_fifa
    expect(hash[0]).to have_key :code_vippredictor
    expect(hash[0]).to have_key :name
    expect(hash[0]).to have_key :image
  end

  it "should extract all teams" do
    hash = @parser.get_teams_hash
    expect(hash.size).to be_eql 32
  end

  # it "should extract the name" do
  #   hash = @parser.get_users_hash

  #   expect(hash[0][:name]).to be_eql "Germany"
  # end

  # it "should extract the fifa code" do
  #   hash = @parser.get_teams_hash

  #   expect(hash[0][:fifa_code]).to be_eql "GMY"
  # end

  # it "should extract the vippredictor code" do
  #   hash = @parser.get_teams_hash

  #   expect(hash[0][:vippredictor_code]).to be_eql "GMY"
  # end




end
