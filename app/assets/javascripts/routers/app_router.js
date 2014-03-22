FantasyFootball.Routers.AppRouter = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },

  routes: {
    '': 'homeShow',
    'leagues/new': 'leagueNew',
    'leagues/:leagueId/teams/new': 'teamNew',
    'leagues/:leagueId/teams/:teamId': 'teamShow',
    'leagues/:leagueId/players': 'playersIndex',
    'leagues/:id': 'leagueShow'
  },

  homeShow: function () {
    console.log('here')
    var homeShowView = new FantasyFootball.Views.Home();

    this._swapView(homeShowView)
  },

  leagueShow: function (id) {
    var league = FantasyFootball.leagues.getOrFetch(id);

    var leagueShowView = new FantasyFootball.Views.LeagueShow({
      model: league,
      collection: league.teams()
    });

    league.teams().fetch();
    this._swapView(leagueShowView);
  },

  leagueNew: function () {
    var league = new FantasyFootball.Models.League();

    var leagueNewView = new FantasyFootball.Views.LeagueNew({
      model: league
    });

    this._swapView(leagueNewView);
  },

  teamShow: function (leagueId, teamId) {
    var team = FantasyFootball.teams.getOrFetch(teamId);

    var teamShowView = new FantasyFootball.Views.TeamShow({
      model: team,
      collection: team.players()
    });

    this._swapView(teamShowView);
  },

  teamNew: function (leagueId) {
    var league = FantasyFootball.leagues.getOrFetch(leagueId);
    var team = new FantasyFootball.Models.Team({
      league_id: leagueId
    });

    var teamNewView = new FantasyFootball.Views.TeamNew({
      model: team,
      league: league
    });

    this._swapView(teamNewView);
  },

  playersIndex: function (leagueId) {
    var players = new FantasyFootball.Collections.Players([], {
      leagueId: leagueId
    });
    var league = FantasyFootball.leagues.getOrFetch(leagueId);

    var playersIndexView = new FantasyFootball.Views.PlayersIndex({
      collection: players,
      league: league
    });

    players.fetch();
    this._swapView(playersIndexView);
  },

  _swapView: function (view) {
    if (this.currentView) {
      this.currentView.remove();
    };
    this.currentView = view;
    this.$rootEl.html(view.render().$el);
  }
});