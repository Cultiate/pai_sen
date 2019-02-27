class FavoritesController < ApplicationController

  def create
    @user = current_user
    if Favorite.create(user_id: @user.id, coach_id: params[:coach_id])
      redirect_back(fallback_location: root_path)
    else
      redirect_to root_url
    end
  end

  def destroy
    @user = current_user
    if @favorite = Favorite.find_by(user_id: @user.id, coach_id: params[:coach_id])
      @favorite.delete
      redirect_back(fallback_location: root_path)
    else
      redirect_to root_url
    end
  end
end
