FantasyFootball.Views.PlayersAddDropModal = Backbone.View.extend({
  initialize: function (options) {
    this.$addedPlayerRow = options.addedPlayerRow;
    this.listenTo(this.collection, 'add remove', this.render);
  },

  template: JST['players/add_drop_modal'],

  render: function () {
    this.$addedPlayerRow.children('.actions').remove();
    this.$addedPlayerRow.children('.status').remove();
    $(this.$addedPlayerRow.children()[0]).html('');

    var modalContent = this.template({
      rosterSpots: this.collection,
      addedPlayerRow: this.$addedPlayerRow.html()
    });

    this.$el.html(modalContent);
    return this;
  }
})