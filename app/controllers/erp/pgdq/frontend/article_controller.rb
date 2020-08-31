module Erp
  module Pgdq
    module Frontend
      class ArticleController < Erp::Frontend::FrontendController
        def index
          @body_class = 'bp-nouveau post-template-default single single-post postid-1833 single-format-standard theme-jannah tie-no-js woocommerce-no-js wrapper-has-shadow block-head-1 magazine2 demo is-lazyload is-thumb-overlay-disabled is-desktop is-header-layout-3 has-header-ad sidebar-right has-sidebar post-layout-1 narrow-title-narrow-media is-standard-format has-mobile-share hide_breaking_news no-js'
          
          @article = Erp::Pgdq::Article.find(params[:article_id])
          @category = @article.category
          @meta_description = @article.meta_description
          @meta_keywords = @article.meta_keywords
        end
      end
    end
  end
end