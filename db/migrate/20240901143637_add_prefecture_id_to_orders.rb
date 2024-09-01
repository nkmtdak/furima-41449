class AddPrefectureIdToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :prefecture_id, :integer, null: false
  end
end
