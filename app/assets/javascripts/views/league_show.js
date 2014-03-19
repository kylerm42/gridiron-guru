FantasyFootball.Views.LeagueShow = Backbone.CompositeView.extend({
  initialize: function (options) {
    this.listenTo(this.model, 'sync', this.render);
    // this.listenTo(this.collection, 'add', this.addTeam)
    this.listenTo(this.collection, 'sync', this.addTeams)
  },

  template: JST['leagues/show'],

  render: function () {
    console.log('rendering league show')
    var renderedContent = this.template({ league: this.model });
    console.log(renderedContent)
    this.$el.html(renderedContent);

    if (!this.collection.findWhere({ user_id: FantasyFootball.currentUser.id })) {
      var joinLeagueLink = $('<a>').attr('href', '#/leagues/' + this.model.id + '/teams/new');
      joinLeagueLink.html('Join this league');

      this.$el.append(joinLeagueLink);
    }
    this.renderSubviews();
    return this
  },

  addTeam: function (team) {
    team.set('league', this.model)
    var teamRowView = new FantasyFootball.Views.TeamRow({ model: team });
    this.addSubview('tbody', teamRowView)
    teamRowView.render();
  },

  addTeams: function (teams) {
    var view = this
    teams.forEach(function (team) {
      view.addTeam(team)
    })
  }
});

FantasyFootball.Views.TeamRow = Backbone.View.extend({
  tagName: 'tr',
  template: JST['teams/row'],

  render: function () {
    var renderedContent = this.template({ team: this.model });

    this.$el.html(renderedContent);
    return this;
  }
})