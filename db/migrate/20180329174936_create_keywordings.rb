class CreateKeywordings < ActiveRecord::Migration[5.1]
  def change
    create_table :keywordings do |t|
      t.references :post, foreign_key: true
      t.references :keyword, foreign_key: true

      t.timestamps
    end
  end
end
