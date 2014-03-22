FantasyFootball.Views.TeamTradeSendModal = Backbone.View.extend({
  initialize: function(options) {
    this.model = options.model;
    this.getPlayerRows = options.getPlayerRows;
    this.otherTeam = options.otherTeam;
    this.listenTo(this.model, 'sync', this.render);
  },

  template: JST['teams/trade_send_modal'],

  render: function () {
    var renderedContent = this.template({
      getPlayerRows: this.getPlayerRows,
      players: this.model.get('players'),
      team: this.model,
      otherTeam: this.otherTeam
    });

    this.$el.html(renderedContent)
    return this;
  }
});