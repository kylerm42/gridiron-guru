FantasyFootball.Collections.Matchups = Backbone.Collection.extend({
  url: '/api/matchups',
  model: FantasyFootball.Models.Matchup,

  getOrFetch: function (id) {
    var model;
    var matchups = this;

    if (model = this.get(id)) {
      model.fetch();
      return model;
    } else {
      model = new FantasyFootball.Models.Matchup({ id: id });
      model.fetch({
        success: function () { matchups.add(model) }
      });

      return model;
    }
  }
});