FantasyFootball.Models.Matchup = Backbone.Model.extend({
  initialize: function (options) {
    if (options.home_team) {
      this._homeTeam = FantasyFootball.teams.getOrFetch(options.home_team.id);
    }
    if (options.away_team) {
      this._awayTeam = FantasyFootball.teams.getOrFetch(options.away_team.id);
    }
  },

  urlRoot: '/api/matchups',

  teams: function () {
    if (!this._teams) {
      this._teams = new FantasyFootball.Collections.Teams([], {
        team: this
      });
    }

    return this._teams;
  }
});