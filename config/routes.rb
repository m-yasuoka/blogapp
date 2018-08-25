Rails.application.routes.draw do
  devise_for :users
  root   'blogs#index'
  get    'blogs'           => 'blogs#index'          #ブログ一覧
  get    'blogs/new'       => 'blogs#new'            #新規投稿画面
  post   'blogs'           => 'blogs#create'         #ブログ投稿機能
  delete 'blogs/:id'       => 'blogs#destroy'        #プログ削除機能
  patch  'blogs/:id'       => 'blogs#update'         #ブログ更新機能
  get    'blogs/:id/edit'  => 'blogs#edit'           #ブログ編集機能
  get    'blogs/random'    => 'blogs#random'         #ブログランダム表示画面
end
