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

require 'spec_helper'

describe Session do
  pending "add some examples to (or delete) #{__FILE__}"
end
