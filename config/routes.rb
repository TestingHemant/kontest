Rails.application.routes.draw do
  resources :problems

  root :to => "contests#index"
  #devise_for :users
  #devise_for :users
  #resources :entries
  resources :entries do
    member do
      post 'upvote'
    end
  end
  #resources :contests
  #get '/auth/:provider', to: 'sessions#create'
  #get 'auth/failure', to: redirect('/')
  #get 'logout', to: 'sessions#destroy', as: 'logout'
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  #get '/users/sign_out' => 'devise/sessions#destroy'
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
  get "/pages/:page" => "pages#show"
  get "/myentries" => "entries#mycontest"
  get "/admin" => "users#admin"
  get "/contestlist" => "contests#contestlist"
  get "/userlist" => "users#userlist"
  get "/users/edit/:id" => "users#edit"
  #devise_for :users do
  #  get '/users/sign_out' => 'devise/sessions#destroy'
  #end
  #get '/auth/:provider/callback', to: 'sessions#create', via: :get
  resources :contests do
    resources :entries
  end
  #For FB login
  #devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  #match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  #devise_for :users, controllers: { registrations: "registrations", omniauth_callbacks: 'omniauth_callbacks' }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
