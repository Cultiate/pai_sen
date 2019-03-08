Rails.application.routes.draw do

  root "root#top"
  get "/contact" => "root#contact"

  get 'tests/test'
  get 'tests/mypage'
  get 'tests/favoriteCoach'
  get 'tests/loginPage'
  get 'tests/questionsPage'
  get 'tests/reservationManagementPage'
  get 'tests/contactUsPage'
  get 'tests/topDemoPage'
  get 'tests/chatroom'


  get "users/:user_id/history" => "users#coaching_history", as: :history_user
  get "users/:user_id/reserve_coaching" => "users#reserve_coaching", as: :reserve_user
  get "users/:user_id/settings" => "users#settings", as: :settings_user

  post "users" => "users#create", as: :users
  get "users/new" => "users#new", as: :new_user
  get "users/:user_id/edit" => "users#edit", as: :edit_user
  get "users/:user_id" => "users#show", as: :user_show
  patch "users/:user_id" => "users#update", as: :user_update
  delete "users/:user_id" => "users#destroy", as: :user_destory
  get "detail/users/:user_id" => "users#detail", as: :user_detail
  patch "detail/users/:user_id" => "users#detail_update", as: :user_detail_update
  get "favorite_coach/:user_id" => "users#favorite_coach", as: :favorite_coach

  post "coaches" => "coaches#create", as: :coaches
  get "coaches/new" => "coaches#new", as: :new_coach
  get "coaches/:coach_id/edit" => "coaches#edit", as: :edit_coach
  get "coaches/:coach_id" => "coaches#show", as: :coach_show
  patch "coaches/:coach_id" => "coaches#update", as: :coach_update
  delete "coaches/:coach_id" => "coaches#destroy", as: :coach_destroy
  get "detail/coaches/:coach_id" => "coaches#detail", as: :coach_detail
  patch "detail/coaches/:coach_id" => "coaches#detail_update", as: :coach_detail_update
  get "message_show/coaches/:coach_id" => "coaches#message_show", as: :coach_message_show
  resources :coaches do
    post 'favorites' => 'favorites#create'
    delete 'c_favorites' => 'favorites#destroy'
  end

  get "account_activations/:user_id/user_edit" => "account_activations#edit", as: :user_edit_account_activation
  get "account_activations/:coach_id/coach_edit" => "account_activations#coach_edit", as: :coach_edit_account_activation

  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :events

  get "messages/user_id" => "messages#user_index", as: :user_msg_index
  get "messages/coach_id" => "messages#coach_index", as: :coach_msg_index
  resources :messages, :only => [:create]

  resources :rooms, :only => [:create, :show]

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  get "coach_login" => "coach_sessions#new"
  post "coach_login" => "coach_sessions#create"
  delete "coach_logout" => "coach_sessions#destroy"

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
