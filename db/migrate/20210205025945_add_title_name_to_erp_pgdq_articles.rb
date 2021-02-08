class AddTitleNameToErpPgdqArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :erp_pgdq_articles, :title_name, :string
  end
end
