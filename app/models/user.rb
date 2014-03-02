# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  first_name      :string(255)      not null
#  last_name       :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :teams, dependent: :destroy
  has_many :managed_leagues,
           foreign_key: :manager_id,
           class_name: "League"
  has_many :leagues,
           through: :teams,
           source: :league
  has_many :sessions
end