FantasyFootball.Collections.Teams = Backbone.Collection.extend({
  url: 'api/teams',

  getOrFetch: function (id) {
    var model;
    var teams = this;

    if (model = this.get(id)) {
      model.fetch();
      return model;
    } else {
      model = new FantasyFootball.Models.Team({ id: id });
      model.fetch({
        success: function () { teams.add(model) }
      });

      return model;
    }
  }
})