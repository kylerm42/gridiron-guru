# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  user_id    :integer          not null
#  league_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Team do
  pending "add some examples to (or delete) #{__FILE__}"
end
