class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :key
      t.string :title
      t.time :duration
      t.time :start_time

      t.timestamps null: false
    end
  end
end
