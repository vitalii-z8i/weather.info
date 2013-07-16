class User
  attr_accessor :id

  def initialize(id)
    send("id=", id)
  end

  # Returns searches for current user
  def searches
    Search.where(user_id: @id)
  end

  # Generates random number which will be used as user id
  def self.generate_user_id
    ( rand(500..3000) * Time.now.to_i )
  end

end
