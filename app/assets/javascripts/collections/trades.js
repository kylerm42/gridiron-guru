FantasyFootball.Collections.Trades = Backbone.Collection.extend({
  url: 'api/trades',
  model: FantasyFootball.Models.Trade,

  getOrFetch: function (id, leagueId) {
    var model;
    var teams = this;

    if (model = this.get(id)) {
      model.fetch();
      return model;
    } else {
      model = new FantasyFootball.Models.Trade({ id: id });
      model.fetch({
        success: function () { teams.add(model) }
      });

      return model;
    }
  }
});