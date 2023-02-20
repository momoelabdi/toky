class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :last_name
      t.string :addres
      t.date :date_of_birth
      t.text :comment
      t.integer :phone
      t.string :email

      t.timestamps
    end
  end
end
