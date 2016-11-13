# == Schema Information
#
# Table name: artifacts
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  coordinate  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Artifact < ActiveRecord::Base
	belongs_to :location
	has_and_belongs_to_many :users
end
