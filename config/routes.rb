Rails.application.routes.draw do
  root controller: :screenshotreqs, action: :index
  resources :screenshotreqs, only: [:index, :create, :new, :show]
end
