FantasyFootball.Collections.Leagues = Backbone.Collection.extend({
  url: '/api/leagues/for_user',
  model: FantasyFootball.Models.League,

  getOrFetch: function (id) {
    var model;
    var leagues = this;

    if (model = this.get(id)) {
      model.fetch();
      return model;
    } else {
      model = new FantasyFootball.Models.League({ id: id });
      model.fetch({
        success: function () { leagues.add(model) }
      })

      return model;
    }
  }
})