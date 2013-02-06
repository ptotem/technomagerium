Summoner::Application.routes.draw do

  resources :encyclopedia_entries


  get "general/privacy"

  get "tomes/show"

  get "welcome/index"

  resources :games

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  mount RailsAdminImport::Engine => '/rails_admin_import', :as => 'rails_admin_import'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  match '/play/:id', :to=>"games#play", :as=>"play"
  match '/games/:id/take_clue/:name/:theme', :to=>"games#take_clue", :as=>"take_clue"
  match '/games/:id/clue_status/:name', :to=>"games#clue_status", :as=>"clue_status"
  match '/games/:id/check/:bitmask', :to=>"games#checker", :as=>"checker"
  match '/games/:id/status', :to=>"games#game_status", :as=>"game_status"
  match '/library/:chapter', :to=>"welcome#library", :as=>"library"
  match '/creatomes/:id', :to=>"tomes#show", :as=>"tome_show"
  match '/creatopedia/:id', :to=>"tomes#creatopedia", :as=>"creatopedia"
  match '/knowledge/:id', :to=>"tomes#knowledge", :as=>"knowledge"
  match '/seetome/:id', :to=>"tomes#admin", :as=>"knowledge_admin"
  match '/policies/privacy', :to=>"general#privacy"
  match '/policies/termsofservice', :to=>"general#tos"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#library'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
