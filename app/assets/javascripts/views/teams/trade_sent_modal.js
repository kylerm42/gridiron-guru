FantasyFootball.Views.TeamTradeSentModal = Backbone.View.extend({
  template: JST['teams/trade_sent_modal'],

  render: function () {
    var renderedContent = this.template({
      trade: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
})