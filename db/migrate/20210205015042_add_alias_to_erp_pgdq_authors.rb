class AddAliasToErpPgdqAuthors < ActiveRecord::Migration[5.1]
  def change
    add_column :erp_pgdq_authors, :alias, :string
  end
end