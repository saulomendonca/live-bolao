require 'rails_helper'
require './spec/helpers/fifa_web_service_stub'

RSpec.describe TeamParser, :type => :service do

  before do
    crawler = VippredictorCrawler.new

    @html = open("./spec/helpers/teams.html")

    crawler = double("VippredictorCrawler")
    allow(crawler).to receive(:get_teams_html_page).and_return(@html)


    webservice = FifaWebserviceStub.new

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

end
