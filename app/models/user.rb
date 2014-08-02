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
  has_one :score
  has_many :game_scores



  validates :name, presence: true
  validates :vippredictor_id, uniqueness: true

  def last_position
    return score.position if score
    0
  end

  def last_points
    return score.points if score
    0
  end
end
