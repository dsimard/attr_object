class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :phone
      t.string :mobile

      t.timestamps null: false
    end
  end
end
