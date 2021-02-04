module Erp
  module Pgdq
    module Frontend
      class HomeController < Erp::Frontend::FrontendController
        def index
          @body_class = 'home page-template-default page page-id-1020 tie-no-js wrapper-has-shadow block-head-1 magazine1 is-thumb-overlay-disabled is-desktop is-header-layout-3 has-header-ad has-builder hide_share_post_top hide_share_post_bottom'
          @slider_articles = Erp::Pgdq::Article.get_slider_articles
          
          @module_01 = Erp::Pgdq::Category.find(2)
          @module_01_get_articles = @module_01.get_articles_for_categories(params)
          @module_01_get_first_article = @module_01_get_articles.first
          
          @module_02 = Erp::Pgdq::Category.find(3)
          @module_02_get_articles = @module_02.get_articles_for_categories(params)
          @module_02_get_first_article = @module_02_get_articles.first
          
          @module_03 = Erp::Pgdq::Category.find(6)
          @module_03_get_articles = @module_03.get_articles_for_categories(params)
          @module_03_get_first_article = @module_03_get_articles.first
          
          @module_04 = Erp::Pgdq::Category.find(4)
          @module_04_get_articles = @module_04.get_articles_for_categories(params)
          @module_04_get_first_article = @module_04_get_articles.first
        end
      end
    end
  end
end