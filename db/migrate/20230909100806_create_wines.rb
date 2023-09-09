class CreateWines < ActiveRecord::Migration[7.0]
  def change
    create_table :wines do |t|
      t.string :name
      t.float :price_euros
      t.string :store_url
      t.float :note

      t.timestamps
    end
  end
end
