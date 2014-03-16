FantasyFootball.Views.LeagueShow = Backbone.CompositeView.extend({
  initialize: function (options) {
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.model.teams(), 'add', this.addTeams)
  },

  rowSubviewClass: FantasyFootball.Views.TeamsTableRow,
  template: JST['leagues/show'],

  render: function () {
    console.log('rendering league show')
    var renderedContent = this.template({ league: this.model });
    this.$el.html(renderedContent);
    this.renderSubviews();
    return this
  },

  events: _.extend({}, Backbone.TableView.prototype.events),

  _lowerTitle: function (model) {
    return model.get("title").toLowerCase();
  },

  addTeams: function (team) {
    team.set('league', this.model)
    var teamRowView = new FantasyFootball.Views.TeamRow({ model: team });
    this.addSubview('tbody', teamRowView)
    teamRowView.render();
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