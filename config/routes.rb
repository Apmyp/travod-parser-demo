# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'extractor#index'
  resources :extractor, only: %i[index create show]
end
