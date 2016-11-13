# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ActiveRecord::Base
    has_and_belongs_to_many :users
    has_many :artifacts, through: :users
    has_many :locations, through: :users
end
