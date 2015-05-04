Rails.application.routes.draw do

  resources :faqs

  get 'password_resets/new'
  get 'password_resets/create'
  
  get 'messenger' => 'messenger#new'
  get 'messenger' => 'messenger#create'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  get    'registrations/success'   => 'registrations#success'
  get    'registrations/'   => 'registrations#new'
  get	 'registrations/fail'	=> 'registrations#fail'
  
  get	 'participants/waiver_checklist' => 'participants#waiver_checklist'
  post	 'participants/update_waivers' => 'participants#update_waivers'
  
  get	 'administrator/dashboard' => 'administrators#dashboard', as: :admin_dashboard
  get	 'participant/dashboard' => 'participants#dashboard', as: :participant_dashboard
  
  resources :accounts

  resources :administrators

  resources :participants

  resources :users

  resources :sponsors

  resources :teams

  resources :conferences
  
  resources :schools
  
  resources :sessions
  
  resources :registrations

  resources :team_members
  
  resources :password_resets, only: [:create]
  
  resources :messenger
  
  get 'welcome/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
