class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.references :item, index: true, foreign_key: true
      t.references :invoice, index: true, foreign_key: true
      t.integer :quantity
      t.decimal :unit_price, precision: 10, scale: 2
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end
