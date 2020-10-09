Rails.application.routes.draw do
  concern :check do
    post :check, on: :collection, defaults: { format: :json }
  end

  concern :toggle do
    post :toggle, on: :member, defaults: { format: :json }
  end

  concern :priority do
    post :priority, on: :member, defaults: { format: :json }
  end

  resources :lexemes, :wordforms, only: %i[destroy update]

  resources :corpora, only: %i[destroy update]
  resources :corpus_texts, :pending_words, only: %i[destroy]

  scope '(:locale)', constraints: { locale: /ru|en/ } do
    resources :lexemes, only: %i[create edit]

    resources :corpora, only: %i[create edit new], concerns: :check
    resources :corpus_texts, only: :create, concerns: :check

    namespace :admin do
      resources :lexeme_types, only: %i[index show] do
        member do
          get :new_lexeme
        end
      end
      resources :lexemes, only: %i[index show]
      resources :wordforms, only: %i[index show] do
        member do
          put 'flags/:flag' => :add_flag, as: :flag
          delete 'flags/:flag' => :remove_flag
        end
      end

      resources :corpora, only: %i[index show]
      resources :corpus_texts, only: %i[index show], concerns: :toggle
      resources :pending_words, only: :index
    end
  end
end
