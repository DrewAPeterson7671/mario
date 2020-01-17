class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.column(:name, :string)
      t.column(:price, :decimal, precision: 7, scale: 2)
      t.column(:country, :string)

      t.timestamps()      
    end
  end
end
