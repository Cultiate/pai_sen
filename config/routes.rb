Rails.application.routes.draw do
  root "root#top"
  
  get 'tests/test'
  get 'tests/mypage'
  get 'tests/favoriteCoach'
  get 'tests/loginPage'
  get 'tests/questionsPage'
  get 'tests/reservationManagementPage'
  get 'tests/contactUsPage'
  get 'tests/topDemoPage'
end
