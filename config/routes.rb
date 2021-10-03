# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'extractor#new'
  resources :extractor, only: %i[new create show] do
    collection do
      post :new_linguist
      post :create_linguist
    end
  end
end
