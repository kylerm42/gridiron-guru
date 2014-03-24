FantasyFootball.Collections.Teams = Backbone.Collection.extend({
  initialize: function (options) {
    this.leagueId = options.leagueId
  },

  url: function () {
    return 'api/leagues/' + this.leagueId + '/teams';
  },
  model: FantasyFootball.Models.Team,

  getOrFetch: function (id, leagueId) {
    var model;
    var teams = this;

    if (model = this.get(id)) {
      model.fetch();
      return model;
    } else {
      model = new FantasyFootball.Models.Team({ id: id, league_id: this.leagueId || leagueId });
      model.fetch({
        success: function () { teams.add(model) }
      });

      return model;
    }
  }
})