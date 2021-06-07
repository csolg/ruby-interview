class AddConfirmableToEmailCredentials < ActiveRecord::Migration[5.2]
  def change
    add_column :email_credentials, :confirmation_token, :string
    add_column :email_credentials, :confirmation_sent_at, :datetime
    add_index :email_credentials, :confirmation_token, unique: true
  end
end
