FantasyFootball.Models.League = Backbone.Model.extend({
  urlRoot: 'api/leagues',

  teams: function () {
    if (!this._teams) {
      this._teams = new FantasyFootball.Collections.Teams([], {
        league: this
      });
    }

    return this._teams;
  }
})