parser = TeamParser.new
teams_hash = parser.get_teams_hash
# puts teams_hash.size

teams_hash.each do |team_hash|
  Team.create!(team_hash)
end
