Rails.application.routes.draw do
  root "root#top"

  get  "student_signup" => "students#new"
  post  "student_signup" => "students#create"
  get "student_send_email" => "students#send_email"
  get "mypage/:student_id" => "students#show", as: :student_mypage

  get  "coach_signup" => "coachs#new"
  post  "coach_signup" => "coachs#create"
  get "coach_send_email" => "coachs#send_email"
  get "mypage/:coach_id" => "coachs#show", as: :coach_mypage
end
