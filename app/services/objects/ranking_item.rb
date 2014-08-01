class RankingItem
  delegate :name, :image, :vippredictor_id, to: :"@user"
  attr_accessor :user, :games_hash
  attr_accessor :last_position, :last_points, :last_position
  attr_accessor :current_points, :current_position



  def position_difference
    diference = 0
    diference = self.last_position - self.current_position if self.last_position
    diference
  end

  def daily_points
    return self.games_hash.map{|game| game[:points]}.inject(0, :+)
  end

end
