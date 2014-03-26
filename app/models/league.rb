# == Schema Information
#
# Table name: leagues
#
#  id              :integer          not null, primary key
#  name            :string(255)      not null
#  manager_id      :integer          not null
#  password_digest :string(255)
#  private         :boolean          default(FALSE)
#  current_week    :integer          default(0)
#  created_at      :datetime
#  updated_at      :datetime
#

class League < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :manager_id, presence: true

  belongs_to :manager,
             foreign_key: :manager_id,
             class_name: "User"
  has_many :teams,
           dependent: :destroy,
           inverse_of: :league
  has_many :users,
           through: :teams,
           source: :users
  has_many :messages,
           as: :messageable,
           dependent: :destroy
  has_many :matchups,
           through: :teams,
           source: :home_matchups

  def password=(secret)
   @password = secret
   self.password_digest = BCrypt::Password.create(secret)
  end

  def is_password?(secret)
   BCrypt::Password.new(self.password_digest).is_password?(secret)
  end

  def private?
    self.private
  end

  def create_matchups!
    teams = self.teams.to_a
    (1..14).each do |week|
      week_teams = teams.dup.shuffle
      5.times do
        Matchup.create!(week: week,
                       home_team_id: week_teams.shift.id,
                       away_team_id: week_teams.shift.id)
      end
    end
  end
end
