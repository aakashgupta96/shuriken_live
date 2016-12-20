Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # You can have the root of your site routed with "root"
  mount Resque::Server, :at => "/resque"

  get '/dashboard' => 'posts#dashboard', as: "dashboard"
  get '/editor/createFrame'
  get '/editor/testFrame'
  post '/posts/objects'
  get '/posts/:id/objects/edit' => 'posts#edit_objects', as: "edit_objects"
  get '/posts/:id/preview' => 'posts#preview', as: "frame_preview"
  root 'posts#dashboard'
  get '/posts/:id/video'=> 'posts#video_id', as: "post_video_id"
  post '/posts/:id/publish' => 'posts#publish' , as: "publish_post"
  resources :posts
  
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
