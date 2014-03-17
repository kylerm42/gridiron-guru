FantasyFootball.Routers.AppRouter = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },

  routes: {
    '': 'homeShow',
    'leagues/:leagueId/teams/:teamId': 'teamShow',
    'leagues/:leagueId/players': 'playersIndex',
    'leagues/:id': 'leagueShow'
  },

  homeShow: function () {

  },

  leagueShow: function (id) {
    var leagues = new FantasyFootball.Collections.Leagues();
    var league = leagues.getOrFetch(id);

    var leagueShowView = new FantasyFootball.Views.LeagueShow({
      model: league,
      collection: league.teams()
    });

    this._swapView(leagueShowView);
  },

  teamShow: function (leagueId, teamId) {
    var teams = new FantasyFootball.Collections.Teams([], {
      leagueId: +leagueId
    });

    var team = teams.getOrFetch(teamId);

    var teamShowView = new FantasyFootball.Views.TeamShow({
      model: team,
      collection: team.players()
    });

    this._swapView(teamShowView);
  },

  playersIndex: function (leagueId) {
    var players = new FantasyFootball.Collections.Players([], {
      leagueId: leagueId
    });

    var leagues = new FantasyFootball.Collections.Leagues();
    var league = leagues.getOrFetch(leagueId);

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