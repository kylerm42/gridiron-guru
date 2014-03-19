FantasyFootball.Collections.Players = Backbone.Collection.extend({
  initialize: function (options) {
    this.set('leagueId', options.leagueId);
  },

  url: function () {
    return 'api/players'
  },
  model: FantasyFootball.Models.Player,

  getOrFetch: function (id) {
    var model;
    var players = this;

    if (model = this.get(id)) {
      model.fetch();
      return model;
    } else {
      model = new FantasyFootball.Models.Player({ id: id });
      model.fetch({
        success: function () { players.add(model) }
      });

      return model;
    }
  }
})