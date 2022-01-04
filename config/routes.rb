# frozen_string_literal: true

Rails.application.routes.draw do
  root 'inglip#index'

  get '/about' => 'inglip#index'
  get '/chat' => 'inglip#index'
end
