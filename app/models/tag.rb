# == Schema Information
#
# Table name: tags
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Tag < ActiveRecord::Base
	validates :name, presence: true
	validates :name, uniqueness: true

	has_and_belongs_to_many :artifacts
end
