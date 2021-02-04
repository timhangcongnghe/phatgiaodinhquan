class AddUseShowListToErpPgdqCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :erp_pgdq_categories, :use_show_list, :boolean, default: false
  end
end