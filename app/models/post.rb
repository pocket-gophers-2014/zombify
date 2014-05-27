class Post < ActiveRecord::Base
  attr_accessible :body, :title, :audience

  def self.latest_zombie_posts
    Post.where("audience = ? or audience = ?", "zombie", "both").limit(20).reverse
  end

  def self.latest_human_posts
    Post.where("audience = ? or audience = ?", "human", "both").limit(20).reverse
  end
end