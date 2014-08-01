require 'rails_helper'

RSpec.describe GameService, :type => :service do

  before :each do
    @game = create(:game, status: "completed", away_team: Team.first, home_team: Team.last)
    create(:result, game: @game)
    User.all.each do |user|
      create(:score, user: user)
      create(:prediction, user: user, game: @game)
      create(:game_score, user: user, game: @game)
    end


    @object = RankingServiceObject.new()
  end

  it "should find an Array of Hash" do
    items = @object.get_sorted_items
    expect(items).to be_a_kind_of(Array)
    expect(items[0]).to be_a_kind_of(RankingItem)
  end

  it "should generate a hash with structury" do
    items = @object.get_sorted_items

    expect(items[0].user).to be_a_kind_of User


    expect(items[0].games_hash).to be_a_kind_of(Array)
    expect(items[0].games_hash[0]).to be_a_kind_of(Hash)


    expect(items[0].games_hash[0]).to have_key :game_id
    expect(items[0].games_hash[0]).to have_key :prediction
    expect(items[0].games_hash[0]).to have_key :points
  end

  it "should extract a ranking item for each user" do
    expect(@object.get_items.size).to be_eql User.all.size
  end

  it "should return result in order" do
    last_user = User.first
    GameScore.where(:user_id => last_user.id).first.update_attributes!(:points => 250)
    first_user = User.last
    GameScore.where(:user_id => first_user.id).first.update_attributes!(:points => 40)

    expect(RankingServiceObject.new().get_sorted_items.first.user["id"]).to be_eql last_user.id
    expect(RankingServiceObject.new().get_sorted_items.last.user["id"]).to be_eql first_user.id
  end



end
