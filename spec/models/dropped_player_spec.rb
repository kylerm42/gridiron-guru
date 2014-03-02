# == Schema Information
#
# Table name: dropped_players
#
#  id          :integer          not null, primary key
#  add_drop_id :integer          not null
#  player_id   :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe DroppedPlayer do
  pending "add some examples to (or delete) #{__FILE__}"
end
