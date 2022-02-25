class CreatePostPublishes < ActiveRecord::Migration[7.0]
  def change
    create_table :post_publishes do |t|
      t.references :post, null: false, foreign_key: { on_delete: :cascade }
      t.date   :published_at, null: false

      t.timestamps
    end

    add_index :post_publishes, %i[created_at post_id], unique: true
  end
end
