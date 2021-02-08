class AddActiveDisplayToErpPgdqArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :erp_pgdq_articles, :active_display, :boolean, default: false
  end
end