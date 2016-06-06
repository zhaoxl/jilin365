Rails.application.routes.draw do
  resource :wechat, only: [:show, :create]
  devise_for :users
  devise_for :admins, :controllers => {sessions: "admin/admins/sessions", passwords: "admin/admins/passwords"},path_names: {sign_out: 'logout'}, path: 'admin/admins'
  
  namespace :admin do
    root 'index#index'
    
    resources :index do
      collection do
        get :pwd
        post :pwd_save
      end
    end
    resources :product_categories do
      member do
        get :move_up
        get :move_down
      end
    end
    resources :products do
      member do
        get :move_up
        get :move_down
        get :set_state
      end
      
      resources :product_logos do
        member do
          get :move_up
          get :move_down
        end
      end
    end
    
    
    resources :orders do
      member do
        get :sent
        patch :sent_save
        get :state
        patch :state_save
      end
    end
    
    resources :banners do
      member do
        get :move_up
        get :move_down
      end
    end
    
    resources :users do
      member do
        get :lock
        patch :lock_save
        get :unlock
      end
    end
    resources :teams do
      member do
        get :users
        post :add_user
        delete :destroy_user
      end
    end
    
    resources :distributions
    resources :distribution_settings
    resources :coupon_templates
    resources :coupons
    resources :single_articles
    resources :settings do
      collection do
        get :new_user_handsel_coupon
        post :new_user_handsel_coupon_save
        get :recharge_card_recharge_handsel
        post :recharge_card_recharge_handsel_save
      end
    end
    resources :recharge_cards
    resources :withdraws
    resources :areas
    resources :user_levels
    resources :permissions do
      collection do
        post :refresh
      end
    end
    resources :roles do
      member do
        get :update_permissions
        post :update_permissions
        get :edit_permissions
        patch :update_permissions
      end
    end
    resources :member_admins
    resources :area_franchises do
      member do
        post :pass
        post :reject
        post :lock
      end
    end
    resources :user_upgrades
    resources :trade_info_categories do
      member do
        get :move_up
        get :move_down
      end
      resources :trade_info_category_attrs do
        member do
          get :move_up
          get :move_down
        end
      end
    end
    resources :trade_infos do
      member do
        get :move_up
        get :move_down
      end
      
      resources :trade_info_images do
        member do
          get :move_up
          get :move_down
        end
      end
      resources :trade_info_attrs do
        collection do
          post :updates
        end
      end
    end
    resources :store_categories do
      member do
        get :move_up
        get :move_down
      end
    end
    resources :stores do
      member do
        get :move_up
        get :move_down
      end
    end
    
    
  end
  
  
  
  
  
  
  
  
  
  root 'index#index'
  resources :trade_infos
  resources :cards
  resources :areas
  resources :stores
  resources :wechat do
    collection do
      get :login
      get :login_get_code_callback
      get :pay
      post :pay_notify
      post :pay_exception_notify
      get :test
    end
  end
  resources :index do
    collection do
      get :about
      get :lock
    end
  end
  
  resources :products
  resources :orders do
    collection do
      get :calculate_coupon
    end
  end
  
  resources :carts do
    collection do
      get :add
      get :remove
      get :reduce
      get :change
    end
  end
  
  resources :shippin_address do
    member do
      get :use
    end
  end
  
  namespace :ajax do
    resources :area do
      collection do
        get :cities
        get :streets
      end
    end
    resources :user do
      collection do
        post :like
        post :sms_captcha
      end
    end
  end
  resources :agents do
    collection do
      get :index2
      get :switch
    end
  end
  resources :single_articles
  
  namespace :member do
    root 'index#index'
    resources :index
    resources :orders do
      member do
        get :set_state
        get :delete
        get :express
        get :share
      end
    end
    resources :distributions do
      collection do
        get :qrcode
      end
    end
    resources :wallets do
      collection do
        get :withdraw
        post :withdraw_save
      end
    end
    resources :recharges
    resources :payments do
      collection do
        get :create
      end
    end
    resources :coupons
    resources :area_franchises
    resources :user_upgrades do
      member do
        get :pass
      end
      collection do
        get :result
      end
    end
    resources :teams do
      collection do
        get :destroy_user
        get :invote_user
        post :invote_user_save
        get :invotes
        get :invotes_pass
        get :invotes_reject
        get :users
      end
    end
    resources :profile
    resources :recommends
    resources :account_books do
      collection do
        get :balance_logs
        get :income_logs
      end
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
