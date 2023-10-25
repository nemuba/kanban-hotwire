# frozen_string_literal: true

Rails.application.routes.draw do
  root 'workspaces#index'
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :workspaces do
    resources :boards do
      resources :cards do
        collection do
          post :move
        end
      end
    end
  end
end
