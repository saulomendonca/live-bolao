require 'rails_helper'

RSpec.describe ScoreParser, :type => :service do

  before do
    # crawler = VippredictorCrawler.new
    # doc = crawler.get_score_html_page
    # file = File.open("/Users/saulomendonca/Documents/desenvolvimento/projetos/live-vippredictor/spec/helpers/score.html", "w")
    # file.puts doc.force_encoding('ISO-8859-1')

    @html = open("/Users/saulomendonca/Documents/desenvolvimento/projetos/live-vippredictor/spec/helpers/score.html")

    crawler = double("VippredictorCrawler")
    allow(crawler).to receive(:get_score_html_page).and_return(@html)


    @parser = ScoreParser.new(crawler)
  end


  it "should find an Array of Hash" do
    hash = @parser.get_scores_hash
    expect(hash).to be_a_kind_of(Array)
    expect(hash[0]).to be_a_kind_of(Hash)
  end

  it "should generate a hash with score structury" do
    hash = @parser.get_scores_hash

    expect(hash[0]).to have_key :user_id
    expect(hash[0]).to have_key :points
    expect(hash[0]).to have_key :position

  end

  it "should extract score for all users" do
    hash = @parser.get_scores_hash
    expect(hash.size).to be_eql 45
  end


end
