module Erp
  module Pgdq
    module Frontend
      class CategoryController < Erp::Frontend::FrontendController
        def index
          @body_class = 'bp-nouveau archive category category-life-style category-6 theme-jannah tie-no-js woocommerce-no-js wrapper-has-shadow block-head-1 magazine2 demo is-lazyload is-thumb-overlay-disabled is-desktop is-header-layout-3 has-header-ad sidebar-right has-sidebar hide_breaking_news no-js'
          @category = Erp::Pgdq::Category.find(params[:category_id])
          @articles = @category.get_articles_for_categories(params).paginate(:page => params[:page], :per_page => 36)
          
          @meta_description = @category.meta_description
          @meta_keywords = @category.meta_keywords
        end
      end
    end
  end
end