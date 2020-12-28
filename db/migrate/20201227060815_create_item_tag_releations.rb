class CreateItemTagReleations < ActiveRecord::Migration[6.0]
  def change
    create_table :item_tag_releations do |t|
      t.references :item, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
  end
end
