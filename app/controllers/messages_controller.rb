class MessagesController < ApplicationController
  before_action :set_message, only: [:edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])
    if @message
        if @message.receiver == current_user
          if @message.status == 0
              @message.update(status: 1, read_at: Time.now.getutc)
              @message.save
          else
            flash[:error] = 'You already read this message'
            @message = nil
          end 
        else
          flash[:error] = 'This isn\'t your message'
          @message = nil
        end 
    else
      flash[:error] = 'Can\'t not find this message'
      @message = nil
    end
  end

  # GET /messages/new
  def new
    @message = Message.new
    @friends = [];
    @friends_list_1 = FriendShip.where("request_from_id=" + current_user.id.to_s)
    if @friends_list_1 != nil
      @friends_list_1.each do |friend|
        @friend_object = {id: friend.request_to.id , name: friend.request_to.name}
        @friends << @friend_object
      end
    end
    @friends_list_2 = FriendShip.where("request_to_id=" + current_user.id.to_s)
    if @friends_list_2 != nil
      @friends_list_2.each do |friend|
        @friend_object = {id: friend.request_from.id , name: friend.request_from.name}
        @friends << @friend_object
      end
    end

    if @friends.count == 0
      flash[:error] = 'You don\'t have friends. Please add friend first'
      redirect_to root_path
    end

  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @receiver = User.find(message_params[:receiver])
    @message = Message.create(sender: current_user, receiver: @receiver, status: 0, message: message_params[:message])
    if @message.save
      flash[:success] = 'Message was successfully sent.'
      redirect_to new_message_path
    else
      flash[:error] = 'Something wrong!'
      render :new
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sent
    @messages = Message.where sender_id: current_user.id
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:receiver, :message)
    end
end
