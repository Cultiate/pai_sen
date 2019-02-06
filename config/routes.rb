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

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
