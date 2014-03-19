FantasyFootball.Models.AddDrop = Backbone.Model.extend({
  urlRoot: function () {
    return 'api/leagues/' + this.get('league_id') + '/add_drops'
  }
})