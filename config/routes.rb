Erp::Pgdq::Engine.routes.draw do
  
  root to: "frontend/home#index"
  
  get "/gioi-thieu-ghpgvn-huyen-dinh-quan" => "frontend/info#about", as: :about
  get "/thanh-vien-ban-tri-su" => "frontend/info#member", as: :member
  get "/danh-sach-tu-vien" => "frontend/info#pagoda", as: :pagoda
  get "/tac-gia/:author_name-aid:author_id" => "frontend/info#author", as: :author
  get "/tim-kiem" => "frontend/info#search", as: :search
  
  get "/chu-de/:category_name-cid:category_id" => "frontend/category#listing", as: :category_listing
  get "/danh-sach/:category_name-cid:category_id" => "frontend/category#detail", as: :category_detail
  get "/:article_name-aid:article_id" => "frontend/article#detail", as: :article_detail
  
  scope "(:locale)", locale: /en|vi/ do
		namespace :backend, module: "backend", path: "backend" do
      resources :categories do
        collection do
          post 'list'
          get 'dataselect'
          put 'move_up'
          put 'move_down'
          put 'archive'
					put 'unarchive'
        end
      end
      
      resources :articles do
        collection do
          post 'list'
          get 'dataselect'
          put 'check_active_display'
          put 'uncheck_active_display'
        end
      end
      
      resources :authors do
        collection do
          post 'list'
          get 'dataselect'
          put 'move_up'
          put 'move_down'
        end
      end
    end
	end
end