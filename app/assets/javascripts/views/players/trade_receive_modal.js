FantasyFootball.Views.PlayersTradeReceiveModal = Backbone.View.extend({
  initialize: function(options) {
    this.model = options.model;
    this.tradePlayer = options.tradePlayer;
    this.currentTeam = options.currentTeam;
    this.listenTo(this.model, 'sync', this.render);
  },

  template: JST['players/trade_receive_modal'],

  render: function () {
    var renderedContent = this.template({
      rosterSpots: this.model.rosterSpots(),
      team: this.model,
      currentTeam: this.currentTeam
    });

    this.$el.html(renderedContent)
            .find('[value="' + this.tradePlayer.id + '"]').attr('checked', 'checked');
    return this;
  }
});