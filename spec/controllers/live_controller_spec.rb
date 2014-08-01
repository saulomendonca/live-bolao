require 'rails_helper'


RSpec.describe LiveController, :type => :controller do



  before do
    @user = User.first
    @home_team = Team.first
    @game = create(:game, status: "in progress", weight: 10, away_team: @home_team, home_team: Team.last)
  end

  let(:valid_session) { {} }

  describe "GET index" do
    it "should render with vippredictor template" do
      get :index, {}, valid_session
      expect(response).to be_success
      expect(response).to render_template(:vippredictor)
    end

    it "should list the ranking" do
      get :index, {}, valid_session
      expect(response).to be_success
      expect(assigns(:ranking_items).size).to eq User.all.size
    end


    it "should get array of games" do
      get :index, {}, valid_session
      expect(response).to be_success
      expect(assigns(:live_games)).to eq(Game.where(:status => "in progress"))
    end
  end

end
