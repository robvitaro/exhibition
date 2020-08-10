class CreateWorks < ActiveRecord::Migration[6.0]
  def change
    create_table :works do |t|
      t.string :name
      t.text :description
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
