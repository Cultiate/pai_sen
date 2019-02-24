class AccountActivationsController < ApplicationController

  def edit
    @user = User.find_by(email: params[:email])
    if @user && !@user.activated? && @user.authenticated?(:activation, params[:user_id])
      @user.update_attribute(:activated, true)
      @user.update_attribute(:activated_at, Time.zone.now)
      log_in @user
      flash[:success] = "Userアカウントが有効化されました。続いてユーザー情報を登録してください。"
      redirect_to user_detail_url(user_id: @user.id)
    else
      flash[:danger] = "有効化ユーザーリンクが正しくありません。"
      redirect_to root_url
    end
  end

  def coach_edit
    @coach = Coach.find_by(email: params[:email])
    if @coach && !@coach.activated? && @coach.authenticated_coach?(:activation, params[:coach_id])

      @coach.update_attribute(:activated, true)
      @coach.update_attribute(:activated_at, Time.zone.now)
      log_in_coach @coach
      flash[:success] = "アカウントが有効化されました。続いてユーザー情報を登録してください。"
      redirect_to coach_detail_url(coach_id: @coach.id)
    else
      flash[:danger] = "有効化コーチリンクが正しくありません。"
      redirect_to root_url
    end

  end
end
