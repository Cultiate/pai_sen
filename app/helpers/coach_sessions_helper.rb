module CoachSessionsHelper

  def log_in_coach(coach)
    session[:coach_id] = coach.id
  end

  def remember_coach(coach)
    coach.remember_coach
    cookies.permanent.signed[:coach_id] = coach.id
    cookies.permanent[:remember_token] = coach.remember_token
  end

  def forget_coach(coach)
    coach.forget_coach
    cookies.delete(:coach_id)
    cookies.delete(:remember_token)
  end

  def current_coach
    if (coach_id = session[:coach_id])
      @current_coach ||= Coach.find_by(id: coach_id)
    elsif (coach_id = cookies.signed[:coach_id])
      @coach = Coach.find_by(id: coach_id)
      if @coach && @coach.authenticated_coach?(:remember, cookies[:remember_token])
        log_in_coach @coach
        @current_coach = @coach
      end
    end
  end

  def coach_logged_in?
    !current_coach.nil?
  end

  def coach_log_out
    forget_coach(current_coach)
    session.delete(:coach_id)
    @current_coach = nil
  end
end
