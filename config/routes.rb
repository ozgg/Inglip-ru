Rails.application.routes.draw do
  resources :lexemes, only: %i[update destroy]

  scope '(:locale)', constraints: { locale: /ru|en/ } do
    root 'index#index'

    resources :lexemes, only: %i[new create edit]

    namespace :admin do
      resources :lexeme_types, only: %i[index show] do
        member do
          get 'new_lexeme'
        end
      end
      resources :lexemes, only: %i[index show]
      resources :words, only: %i[index show]
    end
  end
end
