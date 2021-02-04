class AddAuthorToErpPgdqArticles < ActiveRecord::Migration[5.1]
  def change
    add_reference :erp_pgdq_articles, :author, index: true, references: :erp_pgdq_authors
  end
end