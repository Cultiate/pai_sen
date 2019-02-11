module CoachSessionsHelper

  def log_in(coach)
    session[:coach_id] = coach.id
  end

  def remember(coach)
    coach.remember
    cookies.permanent.signed[:coach_id] = coach.id
    cookies.permanent[:remember_token] = coach.remember_token
  end

  def forget(coach)
    coach.forget
    cookies.delete(:coach_id)
    cookies.delete(:remember_token)
  end

  def current_coach
    if (coach_id = session[:coach_id])
      @current_coach ||= Coach.find_by(id: coach_id)
    elsif (coach_id = cookies.signed[:coach_id])
      @coach = Coach.find_by(id: coach_id)
      if @coach && @coach.authenticated?(:remember, cookies[:remember_token])
        log_in @coach
        @current_coach = @coach
      end
    end
  end

  def coach_logged_in?
    !current_coach.nil?
  end

  def coach_log_out
    forget(current_coach)
    session.delete(:coach_id)
    @current_coach = nil
  end
end
