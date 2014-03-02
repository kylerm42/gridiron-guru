# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  token      :string(255)      not null
#  user_id    :integer          not null
#  device     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Session < ActiveRecord::Base
  validates :user_id, presence: true
  validates :token, presence: true, uniqueness: true

  belongs_to :user
end