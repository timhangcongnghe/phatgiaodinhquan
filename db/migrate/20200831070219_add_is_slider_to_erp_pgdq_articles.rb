class AddIsSliderToErpPgdqArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :erp_pgdq_articles, :is_slider, :boolean, default: false
  end
end
