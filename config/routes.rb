Erp::Pgdq::Engine.routes.draw do
  
  root to: "frontend/home#index"
  get "/gioi-thieu-phat-giao-huyen-dinh-quan" => "frontend/info#about", as: :about
  get "/gioi-thieu-thanh-vien-ban-tri-su" => "frontend/info#member", as: :member
  get "/:category_name-cid:category_id" => "frontend/category#index", as: :category
  get "/:article_name-aid:article_id" => "frontend/article#index", as: :article
  
  scope "(:locale)", locale: /en|vi/ do
		namespace :backend, module: "backend", path: "backend" do
      resources :categories do
        collection do
          post 'list'
          get 'dataselect'
          put 'archive'
          put 'unarchive'
          put 'move_up'
          put 'move_down'
        end
      end
      
      resources :articles do
        collection do
          post 'list'
          get 'dataselect'
          put 'archive'
          put 'unarchive'
        end
      end
    end
	end
end