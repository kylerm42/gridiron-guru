# == Schema Information
#
# Table name: trades
#
#  id          :integer          not null, primary key
#  sender_id   :integer          not null
#  receiver_id :integer          not null
#  status      :integer          default(1), not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Trade < ActiveRecord::Base
  validates :sender_id, :receiver_id, presence: true
  validates :status, presence: true, inclusion: { in: 1..4 }

  belongs_to :sender,
             foreign_key: :sender_id,
             class_name: "Team"
  belongs_to :receiver,
            foreign_key: :receiver_id,
            class_name: "Team"
  has_many :trade_send_players,
           dependent: :destroy,
           inverse_of: :trade
  has_many :send_players,
           through: :trade_send_players,
           source: :player
  has_many :trade_receive_players,
           dependent: :destroy,
           inverse_of: :trade
  has_many :receive_players,
           through: :trade_receive_players,
           source: :player
  has_many :messages,
           as: :messageable,
           dependent: :destroy
end