class AddCustomOrderToErpPgdqAuthors < ActiveRecord::Migration[5.1]
  def change
    add_column :erp_pgdq_authors, :custom_order, :integer
  end
end