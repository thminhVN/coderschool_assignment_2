module UsersHelper
	def is_friend(current_user, to_user)
		@friend_ship = FriendShip.find_by_request_from_id_and_request_to_id(current_user.id, to_user.id)
		if !@friend_ship
			@friend_ship = FriendShip.find_by_request_from_id_and_request_to_id(to_user.id, current_user.id)
		end
		!!@friend_ship
	end	
end
