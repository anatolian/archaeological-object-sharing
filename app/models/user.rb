# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  firstname  :string
#  lastname   :string
#  username   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
	has_and_belongs_to_many :groups
	has_and_belongs_to_many :artifacts
end
