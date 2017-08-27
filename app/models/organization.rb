class Organization < ActiveRecord::Base
	belongs_to :user, required: true

	has_many :members, dependent: :destroy
	has_many :group_members, through: :members, source: :user

	validates :name, length: 5..40
	validates :description, length: 10..255
end
