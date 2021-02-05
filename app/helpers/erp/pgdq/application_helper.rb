module Erp
  module Pgdq
    module ApplicationHelper
      def root_link
        erp_pgdq.root_path
      end
      
      def about_link
        erp_pgdq.about_path
      end
      
      def member_link
        erp_pgdq.member_path
      end
      
      def pagoda_link
        erp_pgdq.pagoda_path
      end
      
      def author_link(author)
        erp_pgdq.author_path(author_id: author.id, author_name: author.alias)
      end
      
      def search_link
        erp_pgdq.search_path
      end
      
      def category_listing_link(category)
        erp_pgdq.category_listing_path(category_id: category.id, category_name: category.alias)
      end
      
      def category_detail_link(category)
        erp_pgdq.category_detail_path(category_id: category.id, category_name: category.alias)
      end
      
      def article_detail_link(article)
        erp_pgdq.article_detail_path(article_id: article.id, article_name: article.alias)
      end
      
      def title(page_title)
        content_for :title, page_title.to_s
      end
    end
  end
end