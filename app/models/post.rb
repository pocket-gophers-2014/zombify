class Post < ActiveRecord::Base
  attr_accessible :body, :title, :audience

  def self.latest_zombie_posts
    Post.where("audience = ? or audience = ?", "zombie", "both").reverse
  end

  def self.latest_human_posts
    Post.where("audience = ? or audience = ?", "human", "both").reverse
  end
end