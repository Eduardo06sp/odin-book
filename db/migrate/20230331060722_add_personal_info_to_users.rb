class AddPersonalInfoToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.text :username
      t.text :biography
      t.text :country
      t.text :state
      t.text :city
      t.text :real_name
    end
  end
end
