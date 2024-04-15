Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/earthquakes_api', to: 'earthquakes#get_earthquakes_api'
  get '/earthquakes', to: 'earthquakes#get_earthquakes'

  resources :comments, only: %i[create destroy]

end
