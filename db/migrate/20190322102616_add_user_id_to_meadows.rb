class AddUserIdToMeadows < ActiveRecord::Migration[5.2]
  def change
    add_reference :meadows, :user, foreign_key: true
  end
end
