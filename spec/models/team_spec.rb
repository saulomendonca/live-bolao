# == Schema Information
#
# Table name: teams
#
#  id                :integer          not null, primary key
#  code_fifa         :string(255)
#  code_vippredictor :string(255)
#  name              :string(255)
#  image             :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

require 'rails_helper'

RSpec.describe Team, :type => :model do

  before do
    create(:team, name: 'GermanyA', image: 'www.image.com/team.png', code_fifa: 'GEMA', code_vippredictor: 'ALEA')
  end


  it "Should be valid when all attributes is valid" do
    team = build(:team, name: 'BrazilA', image: 'www.image.com/team.png', code_fifa: 'BRAA', code_vippredictor: 'BRAA')
    expect(team).to be_valid
  end

  it "Should be invalid when name is blank" do
    team = build(:team, name: '', image: 'www.image.com/team.png', code_fifa: 'BRAA', code_vippredictor: 'BRAA')
    expect(team).not_to be_valid
    expect(team.errors[:name].size).to eq(1)
  end

  it "Should be invalid when code_fifa is blank" do
    team = build(:team, name: 'BrazilA', image: 'www.image.com/team.png', code_fifa: '', code_vippredictor: 'BRAA')
    expect(team).not_to be_valid
    expect(team.errors[:code_fifa].size).to eq(1)
  end
  it "Should be invalid when code_vippredictor is blank" do
    team = build(:team, name: 'BrazilA', image: 'www.image.com/team.png', code_fifa: 'BRAA', code_vippredictor: '')
    expect(team).not_to be_valid
    expect(team.errors[:code_vippredictor].size).to eq(1)
  end

  it "Should be invalid when name is not unique" do
    team = build(:team, name: 'GermanyA', image: 'www.image.com/team.png', code_fifa: 'GEMA', code_vippredictor: 'ALEA')

    expect(team).not_to be_valid
    expect(team.errors[:name].size).to eq(1)
  end

  it "Should be invalid when code_fifa is not unique" do
    team = build(:team, name: 'GermanyA', image: 'www.image.com/team.png', code_fifa: 'GEMA', code_vippredictor: 'ALEA')

    expect(team).not_to be_valid
    expect(team.errors[:code_fifa].size).to eq(1)
  end

  it "Should be invalid when code_vippredictor is not unique" do
    team = build(:team, name: 'GermanyA', image: 'www.image.com/team.png', code_fifa: 'GEMA', code_vippredictor: 'ALEA')

    expect(team).not_to be_valid
    expect(team.errors[:code_vippredictor].size).to eq(1)
  end
end
