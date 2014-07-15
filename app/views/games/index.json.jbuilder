json.array!(@games) do |game|
  json.extract! game, :id, :webservice_id, :vippredictor_id, :status, :complete, :weight, :date, :away_team_id, :home_team_id
  json.url game_url(game, format: :json)
end
