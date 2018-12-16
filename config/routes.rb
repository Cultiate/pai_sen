Rails.application.routes.draw do
  root "root#top"
  get 'tests/test'
  get 'tests/mypage'
  get 'tests/favoriteCoach'
end
