FantasyFootball.Models.Matchup = Backbone.Model.extend({
  urlRoot: '/api/matchups',

  parse: function (json) {
    this.homeTeam = new FantasyFootball.Models.Team(json.home_team);
    delete json.home_team;

    this.awayTeam = new FantasyFootball.Models.Team(json.away_team);
    delete json.away_team;

    return json;
  }
});