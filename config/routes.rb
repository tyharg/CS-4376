Rails.application.routes.draw do
  resources :url_entries
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "url_entries#index"
  get 'search/' => 'url_entries#search', :as => :search
  get 'visit/:id' => 'url_entries#visit', :as => :visit
end
