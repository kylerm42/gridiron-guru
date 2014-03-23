FantasyFootball.Models.Trade = Backbone.Model.extend({
  initialize: function (options) {
    this._sendPlayers = new FantasyFootball.Collections.Players(options.send_players, {
      leagueId: this.get('league_id')
    });
    this._receivePlayers = new FantasyFootball.Collections.Players(options.receive_players, {
      leagueId: this.get('league_id')
    });
  },

  urlRoot: function () {
    return '/api/leagues/' + this.get('league_id') + '/trades';
  },

  sendPlayers: function () {
    if (!this._sendPlayers) {
      this._sendPlayers = new FantasyFootball.Collections.Players([], {
        leagueId: this.get('league_id')
      });
    };

    return this._sendPlayers;
  },

  receivePlayers: function () {
    if (!this._receivePlayers) {
      this._receivePlayers = new FantasyFootball.Collections.Players([], {
        leagueId: this.get('league_id')
      });
    };

    return this._receivePlayers;
  },

  parse: function (json) {
    this.sendPlayers().set(json.send_players);
    delete json.send_players;

    // this.receivePlayers().set(json.receive_players);
    // delete json.receive_players;

    return json;
  }
});