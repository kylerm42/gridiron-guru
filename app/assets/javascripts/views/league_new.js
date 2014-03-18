FantasyFootball.Views.LeagueNew = Backbone.View.extend({
  template: JST['leagues/new'],

  events: {
    'submit form#new-league': 'createLeague'
  },

  render: function () {
    var renderedContent = this.template({
      league: this.model
    });

    this.$el.html(renderedContent);
    return this;
  },

  createLeague: function (event) {
    event.preventDefault();
    var leagueName = $('form#new-league input#league-name').val();
    var teamName = $('form#new-league input#team-name').val();
    var that = this;

    this.model.set('name', leagueName);
    this.model.save({
      team: { name: teamName } }, {
      success: function () {
        Backbone.history.navigate('#/leagues/' + that.model.id)
      }
    });
  }
});