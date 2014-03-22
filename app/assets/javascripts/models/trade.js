FantasyFootball.Models.Trade = Backbone.Model.extend({
  urlRoot: function () {
    return '/api/leagues/' + this.get('league_id') + '/trades';
  }
});