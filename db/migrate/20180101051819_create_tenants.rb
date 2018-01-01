class CreateTenants < ActiveRecord::Migration[5.2]
  def change
    create_table :tenants do |t|
      t.string  :name,   null: false
      t.integer :status, null: false, default: 1

      t.timestamps
    end
  end
end
