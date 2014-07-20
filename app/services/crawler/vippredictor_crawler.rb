class VippredictorCrawler

  CONFIG = YAML.load_file(Rails.root.join('config/config.yml'))[Rails.env]

  def get_users_html_page
    id = CONFIG["vippredictor_group_id"]
    uri = "/en-US/Prediction/Match/#{id}?matchId=6245"
    url = CONFIG["vippredictor_url"] + uri

    return get_page(url)
  end


  def get_teams_html_page
    id = CONFIG["vippredictor_group_id"]
    uri = "/en-US/Prediction/My/#{id}?FlgPeriod=0"
    url = CONFIG["vippredictor_url"] + uri

    return get_page(url)
  end

  def get_user_game_results_html_page(game_id)
    id = CONFIG["vippredictor_group_id"]
    uri = "/en-US/Prediction/Match/#{id}?matchId=#{game_id}"
    url = CONFIG["vippredictor_url"] + uri

    return get_page(url)
  end

  def get_score_html_page()
    id = CONFIG["vippredictor_group_id"]
    first_game_id = CONFIG["vippredictor_first_game_id"]


    uri = "/en-US/Prediction/Match/#{id}?matchId=#{first_game_id}"
    url = CONFIG["vippredictor_url"] + uri

    return get_page(url)
  end

  def get_page(url)
    agent = Mechanize.new
    main_page = get_vip_predictor_main_page(agent)

    login_in_vippredictor(main_page)

    return agent.get(url).content
  end


  def get_vip_predictor_main_page(agent)
    agent.get('http://www.vippredictor.com/pt-BR/Home')
  end

  def login_in_vippredictor(page)
    page.form_with(:action => '/pt-BR/Account') do |f|
      f.EmailLogin  = CONFIG["vippredictor_user"]
      f.SenhaLogin  = CONFIG["vippredictor_pass"]
    end.click_button
  end
end
