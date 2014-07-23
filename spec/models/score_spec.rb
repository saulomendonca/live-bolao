# == Schema Information
#
# Table name: scores
#
#  id         :integer          not null, primary key
#  points     :integer
#  position   :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_scores_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Score, :type => :model do

  before do
    @user =  User.first
  end

  it "Should be valid when all attributes is valid" do
    score = build(:score, points: 5000, position: 2, user_id: @user.id)
    expect(score).to be_valid
  end

  it "Should be not valid when position is equal or less than 0" do
    score = build(:score, points: 5000, position: 0, user_id: @user.id)
    expect(score).not_to be_valid
    score = build(:score, points: 5000, position: -10, user_id: @user.id)
    expect(score).not_to be_valid
  end

  it "Should be not valid when points is  less than 0" do
    score = build(:score, points: 0, position: 1, user_id: @user.id)
    expect(score).to be_valid
    score = build(:score, points: -10, position: 1, user_id: @user.id)
    expect(score).not_to be_valid
  end

  it "Should be not valid when doesn't have user" do
    score = build(:score, points: -10, position: 1, user_id: nil)
    expect(score).not_to be_valid
  end
end
