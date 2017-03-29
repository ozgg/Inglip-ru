Rails.application.routes.draw do
  mount Biovision::Base::Engine, at: '/'

  namespace :admin do
    resources :lexeme_groups, only: [:index, :show]
    resources :words, only: [:index, :show]
  end
end
