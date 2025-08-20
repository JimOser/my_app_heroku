Rails.application.routes.draw do
  resources :people
  resources :books
  resources :songs
  resources :podcasts do
    resources :episodes, only: [:new, :create, :edit, :update, :destroy]
  end

  get "/people_explorer", to: "people_explorer#index", as: :people_explorer

  root "people_explorer#index"
end
