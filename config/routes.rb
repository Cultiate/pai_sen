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
  get 'tests/chatroom'

  post "users" => "users#create", as: :users
  get "users/new" => "users#new", as: :new_user
  get "users/:user_id/edit" => "users#edit", as: :edit_user
  get "users/:user_id" => "users#show", as: :user_show
  patch "users/:user_id" => "users#update", as: :user_update
  delete "users/:user_id" => "users#destroy", as: :user_destory
  get "detail/:user_id" => "users#detail", as: :user_detail
  patch "detail/:user_id" => "users#detail_update", as: :user_detail_update
  get "message_show/:user_id" => "users#message_show"

  post "coachs" => "coachs#create", as: :coachs
  get "coachs/new" => "coachs#new", as: :new_coach
  get "coachs/:coach_id/edit" => "coachs#edit", as: :edit_coach
  get "coachs/:coach_id" => "coachs#show", as: :coach_show
  patch "coachs/:coach_id" => "coachs#update", as: :coach_update
  delete "coachs/:coach_id" => "coachs#destroy", as: :coach_destroy
  get "detail/:coach_id" => "coachs#detail", as: :coach_detail
  patch "detail/:coach_id" => "coachs#detail_update", as: :coach_detail_update
  get "message_show/:coach_id" => "coachs#message_show"

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

  mount ActionCable.server => '/cable'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
