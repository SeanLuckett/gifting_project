Giftola::Application.routes.draw do
  get "dashboard/index"
  get "confirm_email/confirm_address"
  put "confirm_email/send_email_to_address"
  get "confirm_email/save_address_record_confirmed"

  get "support" => "static_pages#support", :as => '/support'

  get "recipients/import_friends", :as => '/import_friends'

  root :to => 'static_pages#home'

  match 'auth/facebook/callback', :to => 'sessions#create'
  match 'auth/failure', :to => redirect('/')
  match 'auth/facebook/logout' => 'sessions#destroy', :as => 'facebook_logout'

  resources :users, :only => [:show, :edit, :update] do
    resources :recipients
    resources :events
  end

  namespace :api do
    get '/recommendations/generate', :to => 'recommendations#generate'
  end

  # Facebook recommends a "Channel file." This is one way to implement it in Rails
  get '/channel.html' => proc {
    [
      200,
      {
        'Pragma'        => 'public',
        'Cache-Control' => "max-age=#{1.year.to_i}",
        'Expires'       => 1.year.from_now.to_s(:rfc822),
        'Content-Type'  => 'text/html'
      },
      ['<script type="text/javascript" src="//connect.facebook.net/en_US/all.js"></script>']
    ]
  }


  mount JasmineRails::Engine => "specs/" unless Rails.env.production?

  if Rails.env.development?
    mount MailPreview => 'mail_view'
  end

  # The priority is based upon order of creati
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
