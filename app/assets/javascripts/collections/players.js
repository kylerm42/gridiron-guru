FantasyFootball.Collections.Players = Backbone.Collection.extend({
  url: 'api/players',
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
        success: function () { palyers.add(model) }
      });

      return model;
    }
  }
})