# frozen_string_literal: true

resources :users, only: :create do
  get :confirm, on: :collection
  get :resend, on: :collection
end

resource :user, only: %i[show], controller: :user
