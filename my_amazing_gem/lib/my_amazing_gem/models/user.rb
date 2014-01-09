class User < ActiveRecord::Base
  #People the user is following
  has_many :following, :class_name => 'Follow', :foreign_key => 'users_following_id' 

  #Followers of the user
  has_many :followers, :class_name => 'Follow', :foreign_key => 'users_followed_id'
  
  has_many :users_following, :class_name => 'User', :foreign_key => 'users_following_id', 
    :through => :followers, :source => :follower
  has_many :users_followed, :class_name => 'User', :foreign_key => 'users_followed_id', 
    :through => :following, :source => :following

  self.include_root_in_json = false

end