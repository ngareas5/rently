Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }
  resources :posts, only: [:create, :show, :index] do
    collection do
      post :add_likes
    end
  end
  resources :comments, only: [:create, :show, :index] do
    collection do
      post :add_likes
    end
  end
end
