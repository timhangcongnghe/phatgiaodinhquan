module Erp
  module Pgdq
    module Frontend
      class HomeController < Erp::Frontend::FrontendController
        def index
          @body_class = 'bp-nouveau page-template-default page theme-jannah tie-no-js woocommerce-no-js boxed-layout wrapper-has-shadow block-head-1 magazine2 demo is-lazyload is-thumb-overlay-disabled is-desktop is-header-layout-3 has-header-ad has-builder hide_breaking_news no-js'
          @slide_articles = Erp::Pgdq::Article.get_slider_articles
        end
      end
    end
  end
end