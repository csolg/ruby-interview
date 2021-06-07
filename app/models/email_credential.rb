# frozen_string_literal: true

class EmailCredential < ApplicationRecord
  has_secure_password

  has_secure_token :confirmation_token

  belongs_to :user
end
