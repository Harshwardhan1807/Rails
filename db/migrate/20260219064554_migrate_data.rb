class MigrateData < ActiveRecord::Migration[8.1]
  def change
    User.find_each do |user|
      user.update_column(:encrypted_password, user.read_attribute(:password))
    end

    remove_column :users, :password, :string
  end
end
