class FifaWebservice

  CONFIG = YAML.load_file(Rails.root.join('config/config.yml'))[Rails.env]


  def get_hash_teams
    countries = get_json("/teams")
    countries.map! do |country|
          {code:country["fifa_code"], name: country["country"]}
    end if countries
    return countries
  end

  def get_daily_games
    get_json("/matches/today")
  end

  private
  def get_json(uri)
    req = Net::HTTP.get(CONFIG["fifa_url"], uri)
    JSON.parse(req)
  end

end
