Rails.application.routes.draw do
  mount Biovision::Base::Engine, at: '/'

  namespace :admin do
    resources :lexeme_groups, only: [:index, :show] do
      member do
        get 'lexemes'
      end
    end
    resources :lexemes, only: [:index, :show]
    resources :words, only: [:index, :show]
  end
end
