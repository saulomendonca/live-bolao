module RankingItemDecorator

  def position_difference_image
    if self.position_difference > 0
      image_path =  "bolao_item_posicao-sobe.png"
    elsif self.position_difference < 0
      image_path =  "bolao_item_posicao-desce.png"
    else
      image_path =  "bolao_item_posicao-neutro.png"
    end
    image_tag image_path, :width => 13, :height => 14
  end


  def predictons(live_games)

    predictions_tag = []

    live_games.each do |game|

      prediction = self.games_hash.find{ |g| g[:game_id] == game.id}
      if prediction
        tags = image_tag(game.home_team_image)
        tags += content_tag(:div, prediction[:prediction], style: "padding: 0 3px; display: inline-block; vertical-align: top;")
        tags += image_tag(game.away_team_image)

        predictions_tag << content_tag(:div, tags, class: "float_l rk_palpite", style: "width: 85px; text-align: center;")
      end
    end


    content_tag(:div, predictions_tag.join(" ").html_safe , class: "float_l rk_palpite", style: "width: 85px; text-align: center;min-height: 45px;")

  end



end
