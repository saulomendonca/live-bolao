class RankingServiceObject

  def initialize()
    @items = []
    process_ranking
  end

  def get_items
    @items
  end

  def get_sorted_items
    @items.sort_by{|i| i.current_points }.reverse
  end



private

  def process_ranking
    @items = []
    User.all.includes(:score, :game_scores).each do |user|

      item = RankingItem.new

      item.user = user


      current_points = 0

      item.last_position = user.last_position
      item.last_points = user.last_points
      current_points += user.last_points

      item.games_hash = []
      user.game_scores.each do |game_score|
        game = {}
        game[:game_id] = game_score.game.id
        game[:prediction] = game_score.prediction
        game[:points] = game_score.points

        current_points += game_score.points

        item.games_hash << game
      end

      item.current_points = current_points

      @items << item



    end

    @items = @items.sort_by{|i| i.current_points }.reverse.each_with_index.map do |item, index|
      position = index + 1
      item.current_position = position
      item
    end

  end

end
