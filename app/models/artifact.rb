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
	has_and_belongs_to_many :tag
end
