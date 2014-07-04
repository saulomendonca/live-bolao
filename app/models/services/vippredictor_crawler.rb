class VippredictorCrawler

  CONFIG = YAML.load_file(Rails.root.join('config/config.yml'))[Rails.env]

  def get_users_html_page

    CONFIG["vippredictor_url"]


    url = '/en-US/Prediction/Match/34531?matchId=6245'
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
