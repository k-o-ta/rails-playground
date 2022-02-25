class CreatePostScreenings < ActiveRecord::Migration[7.0]
  def change
    create_table :post_screenings do |t|
      t.references :post_screening_request, null: false, foreign_key: { on_delete: :cascade }
      t.string :status, null: false
      t.string :screened_by, null: false
      t.timestamps
    end
  end
end
