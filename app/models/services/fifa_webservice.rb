class FifaWebservice

  CONFIG = YAML.load_file(Rails.root.join('config/config.yml'))[Rails.env]


  def get_hash_teams
    teams = []
    req = Net::HTTP.get(CONFIG["fifa_url"], "/teams/")
    paises = JSON.parse(req)
    return paises.map do |jogo|
      {code:jogo["fifa_code"], name: jogo["country"]}
    end
  end
end
