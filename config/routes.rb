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

  resources :lexemes, :wordforms, :words, only: %i[destroy update]

  resources :corpora, only: %i[destroy update]
  resources :corpus_texts, :pending_words, only: %i[destroy]

  resources :sentence_patterns, only: %i[destroy update]

  scope '(:locale)', constraints: { locale: /ru|en/ } do
    scope :api, controller: :api, defaults: { format: :json } do
      get 'normalize/:word' => :normalize
      post 'analyze'
    end

    scope :samples, controller: :samples do
      get 'text', as: :sample_text
      get 'bidding', as: :sample_bidding
      get 'patterns', as: :sample_patterns
      get 'analyze', as: :sample_analyze
    end

    resources :lexemes, only: %i[create edit]
    resources :words, only: :edit, concerns: :check

    resources :corpora, only: %i[create edit new], concerns: :check
    resources :corpus_texts, only: :create, concerns: :check

    resources :sentence_patterns, only: %i[create edit new], concerns: :check

    namespace :admin do
      resources :lexeme_types, only: %i[index show] do
        member do
          get :new_lexeme
        end
      end
      resources :lexemes, :words, only: %i[index show]
      resources :wordforms, only: %i[index show] do
        member do
          put 'flags/:flag' => :add_flag, as: :flag
          delete 'flags/:flag' => :remove_flag
        end
      end

      resources :corpora, only: %i[index show]
      resources :corpus_texts, only: %i[index show], concerns: :toggle do
        member do
          get :lexemes
          get :words
          get :pending_words
        end
      end
      resources :pending_words, only: :index

      resources :sentence_patterns, only: %i[create index show] do
        get 'sample', on: :member
        post 'analyze', on: :collection
      end
    end
  end
end
