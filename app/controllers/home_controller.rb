class HomeController < ApplicationController
	def index
		if !current_user
			redirect_to register_path
		else
			@received_messages = Message.where receiver_id: current_user.id
		end
	end

	def add_friend
		@is_new = false
		@to_user = User.find(params[:to_id]);
		@friend_ship = FriendShip.find_by_request_from_id_and_request_to_id(current_user, @to_user);
		if !@friend_ship
			@friend_ship = FriendShip.find_by_request_from_id_and_request_to_id(@to_user, current_user);
		end

		if !@friend_ship
			@friend_ship = FriendShip.create(request_from: current_user, request_to: @to_user, status: 1)
			@is_new = true
		end
		respond_to do |format|
			if !@is_new
					format.json { render json: {message: 'Already Friend', status: 0}, status: :ok, location: @user }
			else
			      if @friend_ship.save
			        format.json { render json: {message: 'Success', status: 1}, status: :ok, location: @user }
			      else
			        format.json { render json: @friend_ship.errors, status: :unprocessable_entity }
			      end
			end
	    end
	end
end
