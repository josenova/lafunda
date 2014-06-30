Lafunda::Application.routes.draw do
  devise_for :users
  #Games
  get "sportsbook" => 'sport_games#index'
  get "racebook" => 'race_games#index'
  get "poker" => 'poker_games#index'
  get "live_casino" => 'live_casino_games#index'
  get "casino" => 'casino_games#index'
  get "lottery" => 'lotteries#index'

  #Static Pages
  get "faq" => 'pages#faq'
  get "privacy" => 'pages#privacy'
  get "terms" => 'pages#terms'
  get "responsible" => 'pages#responsible'
  get "community" => 'pages#community'
  get "pending_confirmation" => 'pages#confirm'

  #Users and Sessions
  get "register" => 'users#new'
  get "account" => 'users#show'
  get "account/edit" => 'users#edit', as: :edit_account
  get "sign_in" => 'sessions#new'
  get "sign_out" => 'sessions#destroy'

  #Transactions
  get "deposit" => 'transactions#deposit'
  get "withdraw" => 'transactions#withdraw'

  #Support
  get "support" => 'inquiries#index'

  resources "inquiries", only: [:new, :create, :show]
  resources "users", only: [:create, :update]
  resources "sessions", only: [:new, :create, :destroy]


  #get "welcome/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
    #root 'welcome#index'

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

  scope "(:locale)", :locale => /es|en/ do
    root :to => 'welcome#index'
    get "welcome/index"
  end


  match "*path" => redirect("/"), via: [:get, :post] #redirect all 404
end
