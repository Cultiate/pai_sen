Rails.application.routes.draw do
  get 'events/index'
  get 'events/show'
  get 'events/new'
  get 'events/edit'
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
  resources :coachs
  get "detail/:coach_id" => "coachs#detail", as: :detail_coach
  patch "detail/:coach_id" => "coachs#detail_update", as: :coach_detail_update
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :events

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
