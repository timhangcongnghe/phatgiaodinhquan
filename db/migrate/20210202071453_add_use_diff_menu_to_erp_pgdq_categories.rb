class AddUseDiffMenuToErpPgdqCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :erp_pgdq_categories, :use_diff_menu, :boolean, default: false
  end
end