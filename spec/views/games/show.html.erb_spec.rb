require 'rails_helper'

RSpec.describe "games/show", :type => :view do
  before(:each) do
    @game = assign(:game, Game.create!(
      :webservice_id => 1,
      :vippredictor_id => 2,
      :status => "in progress",
      :complete => false,
      :date => Date.today,
      :weight => 3,
      :away_team => Team.first,
      :home_team => Team.last
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/in progress/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
