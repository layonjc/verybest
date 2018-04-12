class CreateBucketLists < ActiveRecord::Migration
  def change
    create_table :bucket_lists do |t|

      t.timestamps

    end
  end
end
