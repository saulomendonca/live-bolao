class FifaWebservice

  CONFIG = YAML.load_file(Rails.root.join('config/config.yml'))[Rails.env]


  def get_hash_teams
    json = get_json("/teams")
    countries = JSON.parse(json)
    countries.map! do |country|
          {code:country["fifa_code"], name: country["country"]}
    end if countries
    return countries
  end

  def get_daily_games
    json = get_json("/matches/today")
    JSON.parse(json)
  end

  private
  def get_json(uri)
    Net::HTTP.get(CONFIG["fifa_url"], uri)
  end

end
