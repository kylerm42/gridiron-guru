FantasyFootball.Models.Team = Backbone.Model.extend({
  urlRoot: 'api/teams',

  players: function () {
    if (!this._players) {
      this._players = new FantasyFootball.Collections.Players([], {
        team: this
      });
    }

    return this._players;
  },

  parse: function (json) {
    this.players().set(json.players);
    delete json.players;

    return json;
  }
})