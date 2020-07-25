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

  concern :removable_image do
    delete :image, action: :destroy_image, on: :member, defaults: { format: :json }
  end

  concern :lock do
    member do
      put :lock, defaults: { format: :json }
      delete :lock, action: :unlock, defaults: { format: :json }
    end
  end

  resources :lexemes, only: %i[destroy update]

  scope '(:locale)', constraints: { locale: /ru|en/ } do
    resources :lexemes, only: %i[create edit]

    namespace :admin do
      resources :lexeme_types, only: %i[index show] do
        member do
          get :new_lexeme
        end
      end
      resources :lexemes, only: %i[index show]
    end
  end
end
