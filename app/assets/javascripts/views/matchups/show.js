FantasyFootball.Views.MatchupShow = Backbone.View.extend({
  template: JST['matchups/show'],

  render: function () {
    var renderedContent = this.template({
      matchup: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
});