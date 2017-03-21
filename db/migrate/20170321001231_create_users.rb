class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :provider
      t.string :uid
      t.string :token
      t.string :refresh_token
      t.integer :karma

      t.timestamps
    end
  end
end
