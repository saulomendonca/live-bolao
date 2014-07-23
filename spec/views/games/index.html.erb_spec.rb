require 'rails_helper'

RSpec.describe "games/index", :type => :view do
  before(:each) do
    Game.destroy_all
    assign(:games, [
      Game.create!(
        :webservice_id => 1,
        :vippredictor_id => 2,
        :status => "in progress",
        :complete => false,
        :date => Date.today,
        :weight => 3,
        :away_team => Team.first,
        :home_team => Team.last
      ),
      Game.create!(
        :webservice_id => 1,
        :vippredictor_id => 2,
        :status => "in progress",
        :complete => false,
        :date => Date.today,
        :weight => 3,
        :away_team => Team.first,
        :home_team => Team.last
      )
    ])
  end

  it "renders a list of games" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "in progress".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
