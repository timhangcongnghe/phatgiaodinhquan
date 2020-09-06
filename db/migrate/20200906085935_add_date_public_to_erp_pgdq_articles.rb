class AddDatePublicToErpPgdqArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :erp_pgdq_articles, :date_public, :datetime
  end
end
