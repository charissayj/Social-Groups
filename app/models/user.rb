class User < ActiveRecord::Base
	has_secure_password

	has_many :organizations, dependent: :destroy
	has_many :members, dependent: :destroy
	has_many :groups, through: :members, source: :organization

	validates :first_name, :last_name, presence: true, length: 2..255
	validates_format_of :first_name, :last_name, with: /\A[-a-z]+\Z/i 
	validates :email, presence: true, uniqueness: true
	validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
	validates :password, length: { minimum: 4 }
end
