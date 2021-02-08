class AddTitleNameToErpPgdqCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :erp_pgdq_categories, :title_name, :string
  end
end
