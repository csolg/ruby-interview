# frozen_string_literal: true

class User < ApplicationRecord
  has_one :email_credential, dependent: :destroy

  enum kind: { student: 0, teacher: 1 }

  accepts_nested_attributes_for :email_credential

  scope :active, -> { where(deleted_at: nil) }
end
