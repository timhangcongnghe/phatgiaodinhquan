module Erp
  module Pgdq
    module Frontend
      class InfoController < Erp::Frontend::FrontendController
        def about
          @body_class = 'post-template-default single single-post postid-970 single-format-standard logged-in admin-bar no-customize-support tie-no-js wrapper-has-shadow block-head-1 magazine1 is-thumb-overlay-disabled is-desktop is-header-layout-3 has-header-ad sidebar-right has-sidebar post-layout-5 narrow-title-narrow-media is-video-format has-mobile-share hide_share_post_top hide_share_post_bottom'
        end
        
        def member
          @body_class = 'post-template-default single single-post postid-970 single-format-standard logged-in admin-bar no-customize-support tie-no-js wrapper-has-shadow block-head-1 magazine1 is-thumb-overlay-disabled is-desktop is-header-layout-3 has-header-ad sidebar-right has-sidebar post-layout-5 narrow-title-narrow-media is-video-format has-mobile-share hide_share_post_top hide_share_post_bottom'
        end
        
        def pagoda
          @body_class = 'post-template-default single single-post postid-970 single-format-standard logged-in admin-bar no-customize-support tie-no-js wrapper-has-shadow block-head-1 magazine1 is-thumb-overlay-disabled is-desktop is-header-layout-3 has-header-ad sidebar-right has-sidebar post-layout-5 narrow-title-narrow-media is-video-format has-mobile-share hide_share_post_top hide_share_post_bottom'
        end
        
        def author
          @body_class = 'archive author author-admin author-1 tie-no-js wrapper-has-shadow block-head-1 magazine1 is-thumb-overlay-disabled is-desktop is-header-layout-3 has-header-ad sidebar-right has-sidebar hide_share_post_top hide_share_post_bottom'
          @author = Erp::Pgdq::Author.find(params[:author_id])
          @articles = Erp::Pgdq::Article.frontend_search(params).where(author_id: params[:author_id]).paginate(:page => params[:page], :per_page => 20)
        end
        
        def search
          @body_class = 'search search-results tie-no-js wrapper-has-shadow block-head-1 magazine1 is-thumb-overlay-disabled is-desktop is-header-layout-3 has-header-ad sidebar-right has-sidebar hide_share_post_top hide_share_post_bottom'
          @articles = Erp::Pgdq::Article.frontend_search(params).paginate(:page => params[:page], :per_page => 20)
        end
      end
    end
  end
end