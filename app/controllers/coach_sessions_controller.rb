class CoachSessionsController < ApplicationController
  protect_from_forgery except: :destroy

  def new
    @coach = Coach.new
  end

  def create
    @coach = Coach.find_by(email: params[:session][:email].downcase)
      if @coach && @coach.authenticate(params[:session][:password])
        if @coach.activated?
          log_in_coach(@coach)
          if params[:session][:remember_me] == '1'
            remember_coach(@coach)
          else
            forget_coach(@coach)
          end
          redirect_to root_url(id: current_coach)
        else
          message  = "コーチアカウントを有効化できませんでした。再度お送りしたリンクをご確認ください。"
          flash[:warning] = message
          redirect_to root_url
        end
      else
        flash.now[:danger] = "メールアドレス、またはパスワードが違います。"
        render "new"
      end
  end

  def destroy
    coach_log_out if coach_logged_in?
    flash[:success] = "ログアウトしました。"
    redirect_to root_url
  end
end
