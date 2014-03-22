FantasyFootball.Models.League = Backbone.Model.extend({
  urlRoot: 'api/leagues',

  teams: function () {
    if (!this._teams) {
      this._teams = new FantasyFootball.Collections.Teams({
        leagueId: this.id
      });
    }

    return this._teams;
  },

  parse: function (json) {
    this.teams().set(json.teams);
    delete json.teams;

    return json;
  }
})