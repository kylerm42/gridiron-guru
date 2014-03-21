FantasyFootball.Models.Team = Backbone.Model.extend({
  initialize: function (options) {
    this.set('league_id', options.league_id);
    this.set('id', options.id);
    if (options.players) {
      var teamPlayers = new FantasyFootball.Collections.Players(options.players, {
        team: this,
        leagueId: options.league_id
      });
      this.set('players', teamPlayers);
    }
  },

  urlRoot: function () {
    return 'api/leagues/' + this.get('league_id') + '/teams';
  },

  players: function () {
    if (!this._players) {
      this._players = new FantasyFootball.Collections.Players([], {
        team: this
      });
    }

    return this._players;
  },

  league: function () {
    if (!this._league) {
      this._league = new FantasyFootball.Models.League();
    };

    return this._league
  },

  parse: function (json) {
    var teamPlayers = new FantasyFootball.Collections.Players(json.players, { team: this });
    this.players().set(json.players);
    delete json.players;

    this.league().set(json.league);
    delete json.league;

    return json;
  }
})