# == Schema Information
#
# Table name: artifacts
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  longitude   :float
#  latitude    :float
#  filepath    :text
#

class Artifact < ActiveRecord::Base
	validates :name, presence: true
	validates :name, uniqueness: true

	has_and_belongs_to_many :users
	has_and_belongs_to_many :tags
	has_many :groups, through: :users

	has_attached_file :file,
		url: "/system/:hash.:extension",
		hash_secret: "abc123"
		

	do_not_validate_attachment_file_type :file

	
end
