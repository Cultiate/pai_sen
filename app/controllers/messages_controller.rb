class MessagesController < ApplicationController

  def user_index
    if @rooms = Room.where(user_id: current_user)
      return @rooms
    end
  end

  def coach_index
    if @rooms = Room.where(coach_id: current_coach)
      return @rooms
    end
  end

  def create
    @message = Message.create(message_params).merge(user_id: current_user.id)
    redirect_to "/rooms/#{@message.room_id}"
  end

  private

    def message_params
      params.require(:message).permit(
        :user_id, :room_id, :content
      )
    end
end
