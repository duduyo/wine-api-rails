class CreateSearches < ActiveRecord::Migration[7.0]
  def change
    create_table :searches do |t|
      t.float :min_price
      t.float :max_price
      t.string :notification_email

      t.timestamps
    end
  end
end
