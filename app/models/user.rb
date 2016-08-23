class User < ApplicationRecord
  has_secure_password

  has_many :groups
  has_many :records
  has_many :outstandings
  has_many :expenses, through: :records

  has_attached_file :profilepic
  validates_attachment_content_type :profilepic, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
