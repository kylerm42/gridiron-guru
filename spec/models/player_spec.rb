# == Schema Information
#
# Table name: players
#
#  id          :integer          not null, primary key
#  first_name  :string(255)      not null
#  last_name   :string(255)      not null
#  position    :string(255)      not null
#  nfl_team_id :integer          default(0), not null
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Player do
  pending "add some examples to (or delete) #{__FILE__}"
end
