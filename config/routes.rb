# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  namespace :dashboard do
    resources :notifications, only: %i[create index]
    resource :user_notifications, only: :create
  end
  resources :user_notifications, only: :index
end
