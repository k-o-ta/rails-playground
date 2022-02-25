class CreatePostPublishDeletes < ActiveRecord::Migration[7.0]
  def change
    create_table :post_publish_deletes do |t|
      t.references :post_publish, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end

    add_index :post_publish_deletes, %i[created_at post_publish_id], unique: true
  end
end
