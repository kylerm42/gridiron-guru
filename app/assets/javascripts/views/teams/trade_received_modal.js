FantasyFootball.Views.TeamTradeReceivedModal = Backbone.View.extend({
  template: JST['teams/trade_received_modal'],

  render: function () {
    var renderedContent = this.template({
      trade: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
})