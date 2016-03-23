class User < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  # log high score
  def add_score(score)
    if score > self.high_score
      $redis.zadd("highscores", score, self.id)
    end
  end

  # table rank
  def rank
    $redis.zrevrank("highscores", self.id) + 1
  end

  # high score
  def high_score
    $redis.zscore("highscores", self.id).to_i
  end

  # top n users
  def self.top(n)
    $redis.zrevrange("highscores", 0, n-1).map{|id| User.find(id)}
  end
end