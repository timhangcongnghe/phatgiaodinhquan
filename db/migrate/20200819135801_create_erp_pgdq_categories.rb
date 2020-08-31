class CreateErpPgdqCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :erp_pgdq_categories do |t|
      t.string :image
      t.string :name
      t.text :content
      t.string :meta_keywords
      t.string :meta_description
      t.string :tags
      t.string :alias
      t.integer :parent_id
      t.integer :custom_order
      t.text :cache_search
      t.boolean :archived, default: false
      t.references :creator, index: true, references: :erp_users

      t.timestamps
    end
  end
end