class FriendShip < ActiveRecord::Base
  belongs_to :request_from, :class_name => 'User'
  belongs_to :request_to, :class_name => 'User'
end
