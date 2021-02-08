class AddTitleNameToErpPgdqAuthors < ActiveRecord::Migration[5.1]
  def change
    add_column :erp_pgdq_authors, :title_name, :string
  end
end
