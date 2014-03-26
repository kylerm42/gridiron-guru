# == Schema Information
#
# Table name: matchups
#
#  id              :integer          not null, primary key
#  week            :integer          not null
#  home_team_id    :integer          not null
#  home_team_score :float
#  away_team_id    :integer          not null
#  away_team_score :float
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe Matchup do
  pending "add some examples to (or delete) #{__FILE__}"
end
