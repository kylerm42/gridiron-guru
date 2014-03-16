FantasyFootball.Views.LeagueShow = Backbone.TableView.extend({
  initialize: function (options) {
    this.listenTo(this.model, "sync", this.render);
  },

  rowSubviewClass: FantasyFootball.Views.TeamsTableRow,
  template: JST['leagues/show'],

  render: function () {
    console.log('rendering league show')
    var renderedContent = this.template({
      league: this.model
    });
    this.$el.html(renderedContent);
    this.renderSubviews();
    return this
  }
})