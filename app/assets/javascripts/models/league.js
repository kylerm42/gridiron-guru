FantasyFootball.Models.League = Backbone.Model.extend({
	initialize: function (options) {
		this._teams = new FantasyFootball.Collections.Teams(options.teams)
	},

  urlRoot: 'leagues',

  teams: function () {
    if (!this._teams) {
      this._teams = new FantasyFootball.Collections.Teams();
    }

    return this._teams;
  },

  parse: function (json) {
    this.teams().set(json.teams);
    delete json.teams;

    return json;
  }
})