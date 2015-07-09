class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.decimal :distance
      t.integer :origin_locality_id
      t.integer :destination_locality_id

      t.timestamps null: false
    end
  end
end
