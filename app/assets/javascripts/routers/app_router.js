FantasyFootball.Routers.AppRouter = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },

  routes: {
    '': 'leagueShow',
		'edit': 'leagueEdit',
    // 'leagues/new': 'leagueNew',
    'leagues/:leagueId/teams/new': 'teamNew',
    'teams/:teamId': 'teamShow',
    'leagues/:leagueId/players': 'playersIndex',
    'leagues/:league_id/matchups/:id': 'matchupShow'
  },

  homeShow: function () {
    var homeShowView = new FantasyFootball.Views.Home();

    this._swapView(homeShowView)
  },

  leagueShow: function (id) {
    var leagueShowView = new FantasyFootball.Views.LeagueShow({
      model: FantasyFootball.league
    });

    this._swapView(leagueShowView);
  },

  leagueNew: function () {
    var league = new FantasyFootball.Models.League();

    var leagueNewView = new FantasyFootball.Views.LeagueNew({
      model: league
    });

    this._swapView(leagueNewView);
  },

  teamShow: function (teamId) {
		var team = FantasyFootball.league.teams().get(teamId);
    var teamShowView = new FantasyFootball.Views.TeamShow({
      model: team
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

  matchupShow: function (league_id, id) {
    var matchup = FantasyFootball.matchups.getOrFetch(id, league_id);

    var matchupShowView = new FantasyFootball.Views.MatchupShow({
      model: matchup
    });

    this._swapView(matchupShowView);
  },

  _swapView: function (view) {
    if (this.currentView) {
      this.currentView.remove();
    };
    this.currentView = view;
    this.$rootEl.html(view.render().$el);
  },

  unauthorizedRedirect: function () {
    if (!FantasyFootball.currentUser.id) {
      Backbone.history.navigate('')
      this.homeShow();

      alertify.log("You must sign in to do that", '', 2000);
      return true
    }
  }
});