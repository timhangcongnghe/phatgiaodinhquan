module Erp
  module Pgdq
    module Frontend
      class CategoryController < Erp::Frontend::FrontendController
        def listing
          @body_class = 'archive category category-tie-life-style category-19 logged-in admin-bar no-customize-support tie-no-js wrapper-has-shadow block-head-1 magazine1 is-thumb-overlay-disabled is-desktop is-header-layout-3 has-header-ad sidebar-right has-sidebar hide_share_post_top hide_share_post_bottom'
          @category = Erp::Pgdq::Category.find(params[:category_id])
          @newest_articles = @category.get_articles_for_categories(params).limit(5)
          @child_categories = @category.children.get_active
          @meta_description = @category.meta_description
        end
        
        def detail
          @body_class = 'archive category category-tie-tech category-18 logged-in admin-bar no-customize-support tie-no-js wrapper-has-shadow block-head-1 magazine1 is-thumb-overlay-disabled is-desktop is-header-layout-3 has-header-ad sidebar-right has-sidebar hide_share_post_top hide_share_post_bottom'
          @category = Erp::Pgdq::Category.find(params[:category_id])
          @newest_articles = @category.get_articles_for_categories(params).limit(5)
          @articles = @category.get_articles_for_categories(params).paginate(:page => params[:page], :per_page => 20)
          @meta_description = @category.meta_description
        end
      end
    end
  end
end