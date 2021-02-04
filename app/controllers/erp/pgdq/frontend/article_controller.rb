module Erp
  module Pgdq
    module Frontend
      class ArticleController < Erp::Frontend::FrontendController
        def detail
          @body_class = 'post-template-default single single-post postid-970 single-format-standard logged-in admin-bar no-customize-support tie-no-js wrapper-has-shadow block-head-1 magazine1 is-thumb-overlay-disabled is-desktop is-header-layout-3 has-header-ad sidebar-right has-sidebar post-layout-5 narrow-title-narrow-media is-video-format has-mobile-share hide_share_post_top hide_share_post_bottom'
          @article = Erp::Pgdq::Article.find(params[:article_id])
          @category = @article.category
          @related_articles = @category.get_articles_for_categories(params).where.not(id: @article).limit(3)
          @meta_description = @article.meta_description
        end
      end
    end
  end
end