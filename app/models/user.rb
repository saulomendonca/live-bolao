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

class User < ActiveRecord::Base
  validates :name, presence: true
  validates :vippredictor_id, uniqueness: true
end
