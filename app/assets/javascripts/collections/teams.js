FantasyFootball.Collections.Teams = Backbone.Collection.extend({
  initialize: function (models, options) {
    this.leagueId = options.leagueId;
  },

  url: function () {
    return 'api/leagues/' + this.leagueId + '/teams';
  },
  model: FantasyFootball.Models.Team,

  getOrFetch: function (id) {
    var model;
    var teams = this;

    if (model = this.get(id)) {
      model.fetch();
      return model;
    } else {
      model = new FantasyFootball.Models.Team({ id: id, leagueId: this.leagueId });
      model.fetch({
        success: function () { teams.add(model) }
      });

      return model;
    }
  }
})