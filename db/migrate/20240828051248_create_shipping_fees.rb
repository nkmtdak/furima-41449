class CreateShippingFees < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_fees do |t|

      t.timestamps
    end
  end
end
