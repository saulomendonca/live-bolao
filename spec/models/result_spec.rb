# == Schema Information
#
# Table name: results
#
#  id             :integer          not null, primary key
#  home_team_goal :integer
#  away_team_goal :integer
#  game_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_results_on_game_id  (game_id)
#

require 'rails_helper'

RSpec.describe Result, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
