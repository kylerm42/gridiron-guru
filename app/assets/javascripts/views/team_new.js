FantasyFootball.Views.TeamNew = Backbone.View.extend({
  initialize: function (options) {
    this.model = options.model;
    this.league = options.league;
  },

  template: JST['teams/new'],

  events: {
    'submit form#new-team': 'createTeam'
  },

  render: function () {
    var renderedContent = this.template({
      team: this.model
    });

    this.$el.html(renderedContent);
    return this;
  },

  createTeam: function (event) {
    event.preventDefault();
    this.model.set('name', $('form#new-team input#team-name').val());
    this.model.set('league_id', this.league.id);
    var that = this;

    this.model.save({}, {
      success: function () {
        Backbone.history.navigate('#/leagues/' + that.league.id + '/teams/' + that.model.id)
      }
    });
  }
})