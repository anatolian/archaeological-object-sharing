# == Route Map
#
#                   Prefix Verb   URI Pattern                       Controller#Action
#         new_user_session GET    /users/sign_in(.:format)          devise/sessions#new
#             user_session POST   /users/sign_in(.:format)          devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)         devise/sessions#destroy
#            user_password POST   /users/password(.:format)         devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)     devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)    devise/passwords#edit
#                          PATCH  /users/password(.:format)         devise/passwords#update
#                          PUT    /users/password(.:format)         devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)           devise/registrations#cancel
#        user_registration POST   /users(.:format)                  devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)          devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)             devise/registrations#edit
#                          PATCH  /users(.:format)                  devise/registrations#update
#                          PUT    /users(.:format)                  devise/registrations#update
#                          DELETE /users(.:format)                  devise/registrations#destroy
#        user_confirmation POST   /users/confirmation(.:format)     devise/confirmations#create
#    new_user_confirmation GET    /users/confirmation/new(.:format) devise/confirmations#new
#                          GET    /users/confirmation(.:format)     devise/confirmations#show
#              user_unlock POST   /users/unlock(.:format)           devise/unlocks#create
#          new_user_unlock GET    /users/unlock/new(.:format)       devise/unlocks#new
#                          GET    /users/unlock(.:format)           devise/unlocks#show
#                     root GET    /                                 artifacts#index
#            artifacts_tag GET    /tags/:id/artifacts(.:format)     tags#artifacts
#                          GET    /tags/sort/:field(.:format)       tags#sort
#                     tags GET    /tags(.:format)                   tags#index
#                          POST   /tags(.:format)                   tags#create
#                  new_tag GET    /tags/new(.:format)               tags#new
#                 edit_tag GET    /tags/:id/edit(.:format)          tags#edit
#                      tag GET    /tags/:id(.:format)               tags#show
#                          PATCH  /tags/:id(.:format)               tags#update
#                          PUT    /tags/:id(.:format)               tags#update
#                          DELETE /tags/:id(.:format)               tags#destroy
#          groups_artifact GET    /artifacts/:id/groups(.:format)   artifacts#groups
#           users_artifact GET    /artifacts/:id/users(.:format)    artifacts#users
#            tags_artifact GET    /artifacts/:id/tags(.:format)     artifacts#tags
#                          GET    /artifacts/sort/:field(.:format)  artifacts#sort
#                artifacts GET    /artifacts(.:format)              artifacts#index
#                          POST   /artifacts(.:format)              artifacts#create
#             new_artifact GET    /artifacts/new(.:format)          artifacts#new
#            edit_artifact GET    /artifacts/:id/edit(.:format)     artifacts#edit
#                 artifact GET    /artifacts/:id(.:format)          artifacts#show
#                          PATCH  /artifacts/:id(.:format)          artifacts#update
#                          PUT    /artifacts/:id(.:format)          artifacts#update
#                          DELETE /artifacts/:id(.:format)          artifacts#destroy
#          artifacts_group GET    /groups/:id/artifacts(.:format)   groups#artifacts
#              users_group GET    /groups/:id/users(.:format)       groups#users
#                          GET    /groups/sort/:field(.:format)     groups#sort
#                   groups GET    /groups(.:format)                 groups#index
#                          POST   /groups(.:format)                 groups#create
#                new_group GET    /groups/new(.:format)             groups#new
#               edit_group GET    /groups/:id/edit(.:format)        groups#edit
#                    group GET    /groups/:id(.:format)             groups#show
#                          PATCH  /groups/:id(.:format)             groups#update
#                          PUT    /groups/:id(.:format)             groups#update
#                          DELETE /groups/:id(.:format)             groups#destroy
#           artifacts_user GET    /users/:id/artifacts(.:format)    users#artifacts
#              groups_user GET    /users/:id/groups(.:format)       users#groups
#                          GET    /users/sort/:field(.:format)      users#sort
#                    users GET    /users(.:format)                  users#index
#                     user GET    /users/:id(.:format)              users#show
#

Rails.application.routes.draw do

  devise_for :users
  root 'artifacts#index'


  resources :tags do
    member do
      get 'artifacts'
    end

    collection do
      get 'sort/:field' => 'tags#sort'
    end
  end

  resources :artifacts do
    member do
      get 'groups'
    end

    member do
      get 'users'
    end

    member do
      get 'tags'
    end

    collection do
      get 'sort/:field' => 'artifacts#sort'
    end
  end

  resources :groups do
    member do
      get 'artifacts'
    end

    member do
      get 'users'
    end

    collection do
      get 'sort/:field' => 'groups#sort'
    end
  end

  resources :users, only: [:index, :show] do
    member do
      get 'artifacts'
    end

    member do
      get 'groups'
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
