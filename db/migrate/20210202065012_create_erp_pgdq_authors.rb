class CreateErpPgdqAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :erp_pgdq_authors do |t|
      t.string :image
      t.string :short_name
      t.string :long_name
      t.text :description
      t.string :email
      t.string :facebook
      t.string :youtube
      t.string :twitter
      t.string :instagram
      t.string :tiktok
      t.boolean :archived, default: false
      t.references :creator, index: true, references: :erp_users
      
      t.timestamps
    end
  end
end