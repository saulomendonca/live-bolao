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

class Team < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :code_fifa, presence: true, uniqueness: true
  validates :code_vippredictor, presence: true, uniqueness: true


end
