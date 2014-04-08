FantasyFootball.Views.LeagueShow = Backbone.CompositeView.extend({
  initialize: function (options) {
		var view = this;
    this.listenTo(this.model, 'sync', this.render);
		this.model.teams().each(function (team) { view.addTeam(team) });
  },

  template: JST['leagues/show'],

  render: function () {
    console.log('rendering league show');
    var renderedContent = this.template({ league: this.model });
    this.$el.html(renderedContent);

    if (!this.model.get('member')) {
      var joinLeagueLink = $('<a>').attr('href', '#/teams/new');
      joinLeagueLink.html('Join this league');

      this.$el.append(joinLeagueLink);
    }
    this.renderSubviews();
    return this
  },

  addTeam: function (team) {
    var teamRowView = new FantasyFootball.Views.TeamRow({ model: team });
    this.addSubview('tbody', teamRowView);
    teamRowView.render();
  }
});

FantasyFootball.Views.TeamRow = Backbone.View.extend({
  tagName: 'tr',
  template: JST['leagues/team_row'],

  render: function () {
    var renderedContent = this.template({ team: this.model });

    this.$el.html(renderedContent);
    return this;
  }
})