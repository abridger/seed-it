class CreateMeadows < ActiveRecord::Migration[5.2]
  def change
    create_table :meadows do |t|
      t.text :description
      t.string :name

      t.timestamps
    end
  end
end
