parser = UserParser.new
users_hash = parser.get_users_hash
users_hash.each do |user_hash|
  User.create!(user_hash)
end
