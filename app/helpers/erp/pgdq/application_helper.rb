module Erp
  module Pgdq
    module ApplicationHelper
      def category_link(category)
        erp_pgdq.category_path(category_id: category.id, category_name: category.alias)
      end
      
      def article_link(article)
        erp_pgdq.article_path(article_id: article.id, article_name: article.alias)
      end
    end
  end
end