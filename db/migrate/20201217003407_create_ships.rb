class CreateShips < ActiveRecord::Migration[6.0]
  def change
    create_table :ships do |t|
      t.string     :postal_code,    null: false
      t.integer    :prefecture_id,  null: false
      t.string     :municipalities, null: false
      t.string     :address,        null: false
      t.string     :building_name
      t.string     :tel,            null: false
      t.references :order,          foreign_key: true
      t.timestamps
    end
  end
end
