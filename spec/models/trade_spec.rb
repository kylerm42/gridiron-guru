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

require 'spec_helper'

describe Trade do
  pending "add some examples to (or delete) #{__FILE__}"
end
