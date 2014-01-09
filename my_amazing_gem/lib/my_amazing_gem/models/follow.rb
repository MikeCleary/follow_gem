class Follow < ActiveRecord::Base
  belongs_to :follower, :class_name => 'Follow', :foreign_key => "users_following_id"
  belongs_to :following, :class_name => 'Follow', :foreign_key => "users_followed_id"
  self.include_root_in_json = false
end