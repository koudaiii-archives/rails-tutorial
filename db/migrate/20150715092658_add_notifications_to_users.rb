class AddNotificationsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :receive_notifications_by_email, :boolean, defalut: false
  end
end
