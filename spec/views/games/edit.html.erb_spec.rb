require 'rails_helper'

RSpec.describe "games/edit", :type => :view do
  before(:each) do
    @game = assign(:game, Game.create!(
      :webservice_id => 1,
      :vippredictor_id => 1,
      :status => "MyString",
      :complete => false,
      :weight => 1,
      :away_team => nil,
      :home_team => nil
    ))
  end

  it "renders the edit game form" do
    render

    assert_select "form[action=?][method=?]", game_path(@game), "post" do

      assert_select "input#game_webservice_id[name=?]", "game[webservice_id]"

      assert_select "input#game_vippredictor_id[name=?]", "game[vippredictor_id]"

      assert_select "input#game_status[name=?]", "game[status]"

      assert_select "input#game_complete[name=?]", "game[complete]"

      assert_select "input#game_weight[name=?]", "game[weight]"

      assert_select "input#game_away_team_id[name=?]", "game[away_team_id]"

      assert_select "input#game_home_team_id[name=?]", "game[home_team_id]"
    end
  end
end
