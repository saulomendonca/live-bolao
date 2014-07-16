require 'rails_helper'

RSpec.describe PredictionParser, :type => :service do

  before do
    @game_id = 10308
    @game = create(:game, vippredictor_id: 10308)

    # crawler = VippredictorCrawler.new
    # doc = crawler.get_user_game_results_html_page(@game_id)
    # file = File.open("/Users/saulomendonca/Documents/desenvolvimento/projetos/live-vippredictor/spec/helpers/predictions", "w")
    # file.puts doc.force_encoding('ISO-8859-1')

    @html = open("/Users/saulomendonca/Documents/desenvolvimento/projetos/live-vippredictor/spec/helpers/predictions.html")

    crawler = double("VippredictorCrawler")
    allow(crawler).to receive(:get_user_game_results_html_page).with(@game_id).and_return(@html)


    @parser = PredictionParser.new(crawler, @game.id)
  end


  it "should find an Array of Hash" do
    hash = @parser.get_predictions_hash
    expect(hash).to be_a_kind_of(Array)
    expect(hash[0]).to be_a_kind_of(Hash)
  end

  it "should generate a hash with team structury" do
    hash = @parser.get_predictions_hash

    expect(hash[0]).to have_key :home_team_goal
    expect(hash[0]).to have_key :away_team_goal
    expect(hash[0]).to have_key :user_id
    expect(hash[0]).to have_key :game_id
  end

  it "should extract all teams" do
    hash = @parser.get_predictions_hash
    expect(hash.size).to be_eql 45
  end


end
