class Post < ActiveRecord::Base
  attr_accessible :body, :title, :audience

  def self.latest_zombie_posts
    Post.where("audience = ? or audience = ?", "zombie", "both").order('created_at DESC')
  end

  def self.latest_human_posts
    Post.where("audience = ? or audience = ?", "human", "both").order('created_at DESC')
  end

  def self.delete_empty_posts(posts)
  	posts.each do |post|
  		if post.title == nil || post.body == nil
  			post.destroy
  		end
  	end
  end
end