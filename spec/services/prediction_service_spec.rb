require 'rails_helper'

RSpec.describe PredictionService, :type => :service do

  before do
    @game_id = 10308
    @game = create(:game, vippredictor_id: @game_id)
    @html = open("/Users/saulomendonca/Documents/desenvolvimento/projetos/live-vippredictor/spec/helpers/predictions.html")

    crawler = double("VippredictorCrawler")
    allow(crawler).to receive(:get_user_game_results_html_page).with(@game_id).and_return(@html)

    @service = PredictionService.new(@game.id, crawler)

  end

  it "should populate predictions for a game" do
    @game.update_attributes!(:status => "in progress")
    expect(Prediction.count).to eq 0
    @service.populate_users_predictions
    expect(Prediction.count).to eq 45
  end

  it "should not populate predictions for a game with future status" do
    @game.update_attributes!(:status => "future")
    expect(Prediction.count).to eq 0
    @service.populate_users_predictions
    expect(Prediction.count).to eq 0
  end




end
