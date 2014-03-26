FantasyFootball.Models.Team = Backbone.Model.extend({
  initialize: function (options) {
    this.set('league_id', options.league_id);
    this.set('id', options.id);
    if (options.players) {
      var teamPlayers = new FantasyFootball.Collections.Players(options.players, {
        team: this,
        leagueId: options.league_id
      });
      this._players = teamPlayers;
    };
    if (options.roster_spots) {
      var rosterSpots = new FantasyFootball.Collections.RosterSpots(
        options.roster_spots, {
        team: this
      });
      this._rosterSpots = rosterSpots;
    };
    if (options.matchup) {
      this.matchup = new FantasyFootball.Models.Matchup(options.matchup);
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

  rosterSpots: function () {
    if (!this._rosterSpots) {
      this._rosterSpots = new FantasyFootball.Collections.RosterSpots([], {
        team: this
      });
    }

    return this._rosterSpots;
  },

  sentTrades: function () {
    if (!this._sentTrades) {
      this._sentTrades = new FantasyFootball.Collections.Trades([], {
        team: this
      });
    }

    return this._sentTrades;
  },

  receivedTrades: function () {
    if (!this._receivedTrades) {
      this._receivedTrades = new FantasyFootball.Collections.Trades([], {
        team: this
      });
    }

    return this._receivedTrades;
  },

  league: function () {
    if (!this._league) {
      this._league = new FantasyFootball.Models.League();
    };

    return this._league
  },

  parse: function (json) {
    this.players().set(json.players);
    delete json.players;

    this.rosterSpots().set(json.roster_spots);
    delete json.roster_spots;

    this.sentTrades().set(json.sent_trades);
    delete json.sent_trades;

    this.receivedTrades().set(json.received_trades);
    delete json.received_trades;

    this.league().set(json.league);
    delete json.league;

    this.matchup = new FantasyFootball.Models.Matchup(json.matchup);
    delete json.matchup;

    return json;
  }
})