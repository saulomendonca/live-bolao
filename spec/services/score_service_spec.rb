require 'rails_helper'

RSpec.describe PredictionService, :type => :service do

  before do
    # @game = create(:score)
    @html = open("./spec/helpers/score.html")

    crawler = double("VippredictorCrawler")
    allow(crawler).to receive(:get_score_html_page).and_return(@html)

    @service = ScoreService.new(crawler)

  end

  it "should get scores for users" do
    expect(Score.count).to eq 0
    @service.populate_score
    expect(Score.count).to eq 45
  end

  it "should clean scores before get new scores" do
    expect(Score.count).to eq 0
    user = User.first
    Score.create!({:user_id => user.id, :points => 1000, :position => 1})
    expect(Score.find_by_user_id(user.id).points).to eq 1000
    @service.populate_score
    expect(Score.where(:user_id => user.id).size).to eq 1
    expect(Score.find_by_user_id(user.id).points).not_to eq 1000
    expect(Score.count).to eq 45
  end

end
