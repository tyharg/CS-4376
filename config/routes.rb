  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users
  get 'settings/purge' => 'settings#purge', :as => :purge
  root "url_entries#index"
  get 'search/' => 'url_entries#search', :as => :search
  get 'visit/:id' => 'url_entries#visit', :as => :visit

  resources :settings
  resources :url_entries

end
