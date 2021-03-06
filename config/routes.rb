Rails.application.routes.draw do

  root :to => 'catalog#index'

  get 'about' => 'about#index'
  get 'catalog' => 'catalog#index'
  get 'checkout' => 'checkout#index'
  get 'admin/manufacturer' => 'admin/manufacturer#index'
  get 'admin/supplier' => 'admin/supplier#index'
  get 'admin/article' => 'admin/article#index'
  get 'admin/order' => 'admin/order#index'
  get 'forum' => 'forum#index'

  get 'about/index'

  get 'admin/manufacturer/new'
  post 'admin/manufacturer/create'
  get 'admin/manufacturer/edit'
  post 'admin/manufacturer/update'
  post 'admin/manufacturer/destroy'
  get 'admin/manufacturer/show'
  get 'admin/manufacturer/show/:id' => 'admin/manufacturer#show'
  get 'admin/manufacturer/index'

  get 'admin/supplier/new'
  post 'admin/supplier/create'
  get 'admin/supplier/edit'
  post 'admin/supplier/update'
  post 'admin/supplier/destroy'
  get 'admin/supplier/show'
  get 'admin/supplier/show/:id' => 'admin/supplier#show'
  get 'admin/supplier/index'

  get 'admin/article/new'
  post 'admin/article/create'
  get 'admin/article/edit'
  post 'admin/article/update'
  post 'admin/article/destroy'
  get 'admin/article/show'
  get 'admin/article/show/:id' => 'admin/article#show'
  get 'admin/article/index'

  post 'admin/order/close'
  post 'admin/order/destroy'
  get 'admin/order/show'
  get 'admin/order/show/:id' => 'admin/order#show'
  get 'admin/order/index'

  get 'catalog/show'
  get 'catalog/show/:id' => 'catalog#show'
  get 'catalog/index'
  get 'catalog/latest'
  get 'catalog/rss'
  get 'catalog/search'

  get 'cart/add'
  post 'cart/add'
  get 'cart/remove'
  post 'cart/remove'
  get 'cart/clear'
  post 'cart/clear'

  get 'user_sessions/new'
  get 'user_sessions/create'
  post 'user_sessions/create'
  get 'user_sessions/destroy'

  get 'user/new'
  post 'user/create'
  get 'user/show'
  get 'user/show/:id' => 'user#show'
  get 'user/edit'
  post 'user/update'

  get 'checkout/index'
  post 'checkout/submit_order'
  get 'checkout/thank_you'

  get 'forum/post'
  post 'forum/create'
  get 'forum/reply'
  get 'forum/destroy'
  post 'forum/destroy'
  get 'forum/show'
  get 'forum/index'

end
