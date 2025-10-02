class CreateActions < ActiveRecord::Migration[7.1]
  def change
    create_table :actions do |t|
      t.references :section, null: false, foreign_key: true
      t.datetime :started_at
      t.datetime :ended_at
      t.string :category

      t.timestamps
    end
  end
end
