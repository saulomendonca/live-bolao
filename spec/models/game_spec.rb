# == Schema Information
#
# Table name: games
#
#  id              :integer          not null, primary key
#  webservice_id   :integer
#  vippredictor_id :integer
#  status          :string(255)
#  complete        :boolean
#  weight          :integer
#  date            :date
#  away_team_id    :integer
#  home_team_id    :integer
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_games_on_away_team_id  (away_team_id)
#  index_games_on_home_team_id  (home_team_id)
#

require 'rails_helper'

RSpec.describe Game, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
