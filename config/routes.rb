# == Route Map
#
#        Prefix Verb   URI Pattern                   Controller#Action
#     locations GET    /locations(.:format)          locations#index
#               POST   /locations(.:format)          locations#create
#  new_location GET    /locations/new(.:format)      locations#new
# edit_location GET    /locations/:id/edit(.:format) locations#edit
#      location GET    /locations/:id(.:format)      locations#show
#               PATCH  /locations/:id(.:format)      locations#update
#               PUT    /locations/:id(.:format)      locations#update
#               DELETE /locations/:id(.:format)      locations#destroy
#     artifacts GET    /artifacts(.:format)          artifacts#index
#               POST   /artifacts(.:format)          artifacts#create
#  new_artifact GET    /artifacts/new(.:format)      artifacts#new
# edit_artifact GET    /artifacts/:id/edit(.:format) artifacts#edit
#      artifact GET    /artifacts/:id(.:format)      artifacts#show
#               PATCH  /artifacts/:id(.:format)      artifacts#update
#               PUT    /artifacts/:id(.:format)      artifacts#update
#               DELETE /artifacts/:id(.:format)      artifacts#destroy
#        groups GET    /groups(.:format)             groups#index
#               POST   /groups(.:format)             groups#create
#     new_group GET    /groups/new(.:format)         groups#new
#    edit_group GET    /groups/:id/edit(.:format)    groups#edit
#         group GET    /groups/:id(.:format)         groups#show
#               PATCH  /groups/:id(.:format)         groups#update
#               PUT    /groups/:id(.:format)         groups#update
#               DELETE /groups/:id(.:format)         groups#destroy
#         users GET    /users(.:format)              users#index
#               POST   /users(.:format)              users#create
#      new_user GET    /users/new(.:format)          users#new
#     edit_user GET    /users/:id/edit(.:format)     users#edit
#          user GET    /users/:id(.:format)          users#show
#               PATCH  /users/:id(.:format)          users#update
#               PUT    /users/:id(.:format)          users#update
#               DELETE /users/:id(.:format)          users#destroy
#

Rails.application.routes.draw do

  root 'artifacts#index'

  resources :locations do
    member do
      get 'numberArtifacts'
    end

    collection do
      get 'sort/:field' => 'locations#sort'
    end
  end

  resources :artifacts do
    collection do
      get 'sort/:field' => 'artifacts#sort'
    end
  end

  resources :groups do
    member do
      get 'numberArtifacts'
    end

    collection do
      get 'sort/:field' => 'groups#sort'
    end
  end

  resources :users do
    member do
      get 'numberArtifacts'
    end

    collection do
      get 'sort/:field' => 'users#sort'
    end
  end

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
