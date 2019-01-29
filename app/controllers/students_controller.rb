class StudentsController < ApplicationController
  def new
    @student = Student.new
  end

  def show
    @student = current_student
  end

  def create
    @student = Student.new(student_params)
      if @student.save
        @student.send_activation_email
        redirect_to send_email_url
      end
  end

  def send_email
  end

  private

    def student_params
      params.require(:student).permit(
        :name, :kana, :email, :birthday,
        :university, :department, :graduate_year, :greeting,
        :password, :password_confirmation,
        :user_image, :provider, :uid,
      )
    end
end
