Weather::Application.routes.draw do

  root :to => 'searches#index'

  resources :searches, only: [:create, :destroy]


  get "content/about"

  get "content/sources"

end
