# == Schema Information
#
# Table name: leagues
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  manager_id :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class League < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :manager_id, presence: true

  has_many :teams,
           dependent: :destroy
  has_many :users,
           through: :teams,
           source: :users
  belongs_to :manager,
             foreign_key: :manager_id,
             class_name: "User"
  has_many :messages,
           as: :messageable,
           dependent: :destroy
end