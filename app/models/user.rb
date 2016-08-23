class User < ApplicationRecord
  has_secure_password
  has_many :user_groups
  has_many :groups, through: :user_groups
  has_many :records
  has_many :outstandings
  has_many :expenses, through: :records

	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  has_attached_file :profilepic
  validates  :first_name,:last_name, presence: true
  validates  :email, presence: true, uniqueness: {case_sensitive: false}, format: {with: EMAIL_REGEX}
  validates_attachment_content_type :profilepic, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
