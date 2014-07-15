require 'rails_helper'

RSpec.describe "games/index", :type => :view do
  before(:each) do
    Game.destroy_all
    assign(:games, [
      Game.create!(
        :webservice_id => 1,
        :vippredictor_id => 2,
        :status => "Status",
        :complete => false,
        :weight => 3,
        :away_team => nil,
        :home_team => nil
      ),
      Game.create!(
        :webservice_id => 1,
        :vippredictor_id => 2,
        :status => "Status",
        :complete => false,
        :weight => 3,
        :away_team => nil,
        :home_team => nil
      )
    ])
  end

  it "renders a list of games" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
