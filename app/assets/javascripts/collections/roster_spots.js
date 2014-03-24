FantasyFootball.Collections.RosterSpots = Backbone.Collection.extend({
  url: '/api/roster_spots',
  model: FantasyFootball.Models.RosterSpot,

  getOrFetch: function (id) {
    var model;
    var rosterSpots = this;

    if (model = this.get(id)) {
      model.fetch();
      return model;
    } else {
      model = new FantasyFootball.Models.Player({ id: id });
      model.fetch({
        success: function () { rosterSpots.add(model) }
      });

      return model;
    }
  },
});