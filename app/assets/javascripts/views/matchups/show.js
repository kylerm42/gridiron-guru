FantasyFootball.Views.MatchupShow = Backbone.View.extend({
  initialize: function () {
    this.listenTo(this.model, 'sync change', this.render)
  },

  template: JST['matchups/show'],

  render: function () {
    console.log('rendering matchup show')
    var renderedContent = this.template({
      matchup: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
});