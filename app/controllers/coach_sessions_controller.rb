class CoachSessionsController < ApplicationController
  protect_from_forgery except: :destroy

  def new
  end

  def create
    @coach = Coach.find_by(email: params[:session][:email].downcase)
      if @coach && @coach.authenticate(params[:session][:password])
        if @coach.activated?
          log_in(@coach)
          if params[:session][:remember_me] == '1'
            remember(@coach)
          else
            forget(@coach)
          end
          redirect_to coach_url(id: current_coach)
        else
          message  = "アカウントを有効化できませんでした。再度お送りしたリンクをご確認ください。"
          flash[:warning] = message
          redirect_to root_url
        end
      else
        flash.now[:danger] = "メールアドレス、またはパスワードが違います。"
        render "new"
      end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "ログアウトしました。"
    redirect_to root_url
  end
end
