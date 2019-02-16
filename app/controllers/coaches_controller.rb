class CoachesController < ApplicationController

  def new
    @coach = Coach.new
  end

  def show
    @coach = Coach.find(params[:coach_id])
  end

  def detail
    @coach = Coach.find(params[:coach_id])
  end

  def create
    @coach = Coach.new(coach_params)
      if @coach.save
        @coach.send_activation_email
        flash[:success] = "登録メールアドレスに本登録のURLを送信しました。"
        redirect_to root_url
      end
  end

  def detail_update
    @coach = Coach.find(params[:coach_id])
    @coach.update_attributes(coach_params)
    if @coach.save
      flash[:success] = "登録が完了しました。"
      redirect_to @coach
    else
      render "detail"
    end
  end

  def password_update
    @coach = Coach.find(params[:coach_id])
    @coach.update_attributes(coach_params)
    if @coach.save
      flash[:success] = "登録が完了しました。"
      redirect_to @coach
    else
      render "detail"
    end
  end

  private

    def coach_params
      params.require(:coach).permit(
        :name, :kana, :email, :birthday, :status, :company, :business, :occupation, :greeting,
        :password, :password_confirmation, :remember_digest, :activation_digest, :activated, :activated_at,
        :coach_image, :provider, :uid, :reset_digest, :reset_sent_at
      )
    end

    def correct_coach
      @coach = Coach.find_by(id: params[:coach_id])
      redirect_to root_url unless current_coach?(@coach)
    end
end
