# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  user_id    :integer          not null
#  league_id  :integer          not null
#  wins       :integer          default(0), not null
#  losses     :integer          default(0), not null
#  ties       :integer          default(0), not null
#  waiver     :integer          default(1), not null
#  created_at :datetime
#  updated_at :datetime
#

class Team < ActiveRecord::Base
  after_create :league_full?
  before_save :fill_roster_spots
  validates :league, presence: true
  validates :name, :user_id, presence: true, uniqueness: { scope: :league_id }

  belongs_to :owner,
             foreign_key: :user_id,
             class_name: "User"
  belongs_to :league,
             inverse_of: :teams
  has_many :roster_spots,
           foreign_key: :team_id,
           class_name: "RosterSpot"
  has_many :players,
           through: :roster_spots,
           source: :player
  has_many :add_drops
  has_many :sent_trades,
           foreign_key: :sender_id,
           class_name: "Trade"
  has_many :received_trades,
           foreign_key: :receiver_id,
           class_name: "Trade"
  has_many :watched_player_joins,
           foreign_key: :team_id,
           class_name: "WatchedPlayer",
           inverse_of: :team
  has_many :watched_players,
           through: :watched_player_joins,
           source: :player
  has_many :home_matchups,
           foreign_key: :home_team_id,
           class_name: "Matchup"
  has_many :away_matchups,
           foreign_key: :away_team_id,
           class_name: "Matchup"

  def matchups
    Matchup.where("home_team_id = ? OR away_team_id = ?", self.id, self.id).first
  end

  def weekly_matchup(week)
    Matchup.where("week = ? AND (home_team_id = ? OR away_team_id = ?)",
                  week, self.id, self.id).first
  end

  def current_matchup
    Matchup.where("week = ? AND (home_team_id = ? OR away_team_id = ?)",
    self.league.current_week, self.id, self.id).first
  end

  private

    def league_full?
      @league = self.league
      if @league.teams.count == 10
        @league.current_week = 1
        @league.create_matchups!
        @league.save!
      end
    end

    def fill_roster_spots
      roster_spots = self.roster_spots
      qbs = roster_spots.select { |rs| rs.position == 'QB' }
      rbs = roster_spots.select { |rs| rs.position == 'RB' }
      wrs = roster_spots.select { |rs| rs.position == 'WR' }
      tes = roster_spots.select { |rs| rs.position == 'TE' }
      rwts = roster_spots.select { |rs| rs.position == 'R/W/T' }
      ks = roster_spots.select { |rs| rs.position == 'K' }
      defs = roster_spots.select { |rs| rs.position == 'DEF' }
      valid = false

      until valid
        valid = true
        if qbs.length < 1
          roster_spot = self.roster_spots.build({ position: 'QB', player_id: nil })
          qbs << roster_spot
          valid = false
        end
        if rbs.length < 2
          roster_spot = self.roster_spots.build({ position: 'RB', player_id: nil })
          rbs << roster_spot
          valid = false
        end
        if wrs.length < 2
          roster_spot = self.roster_spots.build({ position: 'WR', player_id: nil })
          wrs << roster_spot
          valid = false
        end
        if tes.length < 1
          roster_spot = self.roster_spots.build({ position: 'TE', player_id: nil })
          tes << roster_spot
          valid = false
        end
        if rwts.length < 1
          roster_spot = self.roster_spots.build({ position: 'R/W/T', player_id: nil })
          rwts << roster_spot
          valid = false
        end
        if ks.length < 1
          roster_spot = self.roster_spots.build({ position: 'K', player_id: nil })
          ks << roster_spot
          valid = false
        end
        if defs.length < 1
          roster_spot = self.roster_spots.build({ position: 'DEF', player_id: nil })
          defs << roster_spot
          valid = false
        end
      end

      roster_spots.select { |rs| rs.position == 'BN' && rs.player_id == nil }
                  .each { |rs| rs.destroy }
    end
end