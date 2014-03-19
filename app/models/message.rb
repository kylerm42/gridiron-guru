# == Schema Information
#
# Table name: messages
#
#  id               :integer          not null, primary key
#  body             :text
#  poster_id        :integer
#  messageable_id   :integer
#  messageable_type :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

class Message < ActiveRecord::Base
  validates :poster_id, :body, :messageable_id, :messageable_type, presence: true

  belongs_to :user
  belongs_to :messageable
end