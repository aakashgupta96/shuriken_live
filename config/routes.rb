Rails.application.routes.draw do
  #devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions", :omniauth_callbacks => "users/omniauth_callbacks"}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # You can have the root of your site routed with "root"
  mount Resque::Server, :at => "/resque"

  # devise_scope :user do
  #   delete 'sign_out', :to => 'users/sessions#destroy', :as => :destroy_user_session
  # end
  root 'posts#home'
  get '/steps' => 'posts#steps', as: "steps"
  #get '/editor/createFrame'
  #get '/editor/testFrame'
  post '/posts/objects'
  #get '/posts/:id/objects/edit' => 'posts#edit_objects', as: "edit_objects"
  get '/posts/:id/preview' => 'posts#preview', as: "frame_preview"
  #get '/posts/:id/video'=> 'posts#video_id', as: "post_video_id"
  post '/posts/:id/publish' => 'posts#publish' , as: "publish_post"
  get '/posts/:id/finish' => 'posts#start_update', as: "finish"
  resources :posts, :except => [:edit , :show , :index , :update, :destroy]
  
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

  get "*path" => redirect('/')
  

end
