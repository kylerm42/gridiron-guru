FantasyFootball.Views.TeamTradeConfirmModal = Backbone.View.extend({
  initialize: function (options) {
    this.tradeForRows = options.tradeForRows;
    this.tradeAwayRows = options.tradeAwayRows;
    this.team = options.team;
    this.otherTeam = options.otherTeam;
  },

  template: JST['teams/trade_confirm_modal'],

  render: function () {
    var renderedContent = this.template({
      tradeForRows: this.tradeForRows,
      tradeAwayRows: this.tradeAwayRows,
      team: this.team,
      otherTeam: this.otherTeam
    });

    this.$el.html(renderedContent);
    return this;
  }
});