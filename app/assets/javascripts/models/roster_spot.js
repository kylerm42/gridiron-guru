FantasyFootball.Models.RosterSpot = Backbone.Model.extend({
  initialize: function (options) {
    this.player = new FantasyFootball.Models.Player(options.player)
		this.unset('player')
  },

  urlRoot: 'api/roster_spots',

  parse: function (json) {
    this.player = new FantasyFootball.Models.Player(json.player);
    delete json.player

    return json;
  }
});