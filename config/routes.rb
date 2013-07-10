Weather::Application.routes.draw do

  root :to => 'searches#index'

  resources :searches, only: [:create, :destroy]

end
