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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team, :class => 'Team' do
    code_fifa "BRA"
    code_vippredictor "BRA"
    name "Brazil"
    image "image.png"
  end
end
