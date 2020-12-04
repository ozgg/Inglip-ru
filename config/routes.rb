# frozen_string_literal: true

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

  namespace :admin do
    resources :lexeme_types, only: %i[index show] do
      member do
        get :new_lexeme
      end
    end
    resources :lexemes, :words, concerns: :check
    resources :wordforms do
      member do
        put 'flags/:flag' => :add_flag, as: :flag
        delete 'flags/:flag' => :remove_flag
      end
    end

    resources :corpora, concerns: :check
    resources :corpus_texts, concerns: %i[check toggle] do
      member do
        get :lexemes
        get :words
        get :pending_words
      end
    end
    resources :pending_words

    resources :sentence_patterns, concerns: :check do
      get 'sample', on: :member
      post 'analyze', on: :collection
    end
  end
end
