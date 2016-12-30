class RemoveStartTimeFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :start_time, :datetime
  end
end
