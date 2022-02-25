class CreatePostScreeningRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :post_screening_requests do |t|
      t.references :post, null: false, foreign_key: { on_delete: :cascade }
      t.string :requested_by, null: false

      t.timestamps
    end
  end
end
