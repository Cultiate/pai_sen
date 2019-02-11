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
  get "detail/:id" => "users#detail", as: :detail_user
  patch "detail/:id" => "users#detail_update", as: :detail_update

  resources :coaches
  get "coaches/detail/:id" => "coaches#detail", as: :detail_coach
  patch "coaches/detail/:id" => "coaches#detail_update", as: :coach_detail_update

  get "account_activations/:id/coach_edit" => "account_activations#coach_edit", as: :coach_edit_account_activation
  resources :account_activations, only: [:edit]

  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :events

  get "coach_login" => "coach_sessions#new"
  post "coach_login" => "coach_sessions#create"
  delete "coach_logout" => "coach_sessions#destroy"

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
