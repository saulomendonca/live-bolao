# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  image           :string(255)
#  name            :string(255)
#  vippredictor_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#

require 'rails_helper'

RSpec.describe User, :type => :model do

  it "Should be valid when all attributes is valid" do
    user = build(:user, name: 'Saulo Mendonça', image: 'www.image.com/image.png', vippredictor_id: 54321)
    expect(user).to be_valid
  end

  it "Should be invalid when name is blank" do
    user = build(:user, name: '', image: 'www.image.com/image.png', vippredictor_id: 54321)
    expect(user).not_to be_valid
    expect(user.errors[:name].size).to eq(1)
  end
  it "Should be invalid when name is nil" do
    user = build(:user, name: nil, image: 'www.image.com/image.png', vippredictor_id: 54321)
    expect(user).not_to be_valid
    expect(user.errors[:name].size).to eq(1)
  end

  it "Should be invalid when vippredictor_id is not unique" do
    create(:user, name: "Saulo", image: 'www.image.com/image.png', vippredictor_id: 54321)
    user = build(:user, name: "Saulo", image: 'www.image.com/image.png', vippredictor_id: 54321)
    expect(user).not_to be_valid
    expect(user.errors[:vippredictor_id].size).to eq(1)
  end

  # it "orders by last name" do
  #   lindeman = User.create!(first_name: "Andy", last_name: "Lindeman")
  #   chelimsky = User.create!(first_name: "David", last_name: "Chelimsky")

  #   expect(User.ordered_by_last_name).to eq([chelimsky, lindeman])
  # end



end
