FantasyFootball.Models.Matchup = Backbone.Model.extend({
  urlRoot: '/api/matchups',

  // homeTeam: function () {
  //   if (!this._homeTeam) {
  //     this._homeTeam = FantasyFootball.teams.getOrFetch(this.get('home_team_id'));
  //   };
  //
  //   return this._homeTeam;
  // },
  //
  // awayTeam: function () {
  //   if (!this._awayTeam) {
  //     this._awayTeam = FantasyFootball.teams.getOrFetch(this.get('away_team_id'));
  //   };
  //
  //   return this._awayTeam;
  // }
});