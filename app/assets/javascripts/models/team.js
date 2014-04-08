FantasyFootball.Models.Team = Backbone.Model.extend({
  initialize: function (options) {
    this._rosterSpots = new FantasyFootball.Collections.RosterSpots(options.roster_spots);
    this._sentTrades = new FantasyFootball.Collections.Trades(options.sent_trades);
    this._receivedTrades = new FantasyFootball.Collections.Trades(options.received_trades);
    if (options.matchup) {
      this.matchup = new FantasyFootball.Models.Matchup(options.matchup);
    }
  },

  urlRoot: function () {
    return 'api/leagues/' + this.get('league_id') + '/teams';
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

  parse: function (json) {
    this.rosterSpots().set(json.roster_spots);
    delete json.roster_spots;

    this.sentTrades().set(json.sent_trades);
    delete json.sent_trades;

    this.receivedTrades().set(json.received_trades);
    delete json.received_trades;

    this.matchup = new FantasyFootball.Models.Matchup(json.matchup);
    delete json.matchup;

    return json;
  }
})