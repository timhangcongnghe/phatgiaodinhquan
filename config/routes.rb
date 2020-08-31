Erp::Pgdq::Engine.routes.draw do
  
  root to: "frontend/home#index"
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