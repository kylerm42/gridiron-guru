FantasyFootball.Views.TeamAddDropModal = Backbone.View.extend({
  initialize: function (options) {
    this.collection = options.collection;
    this.$addedPlayerRow = options.addedPlayerRow;
  },

  template: JST['teams/add_drop_modal'],

  render: function () {
    this.$addedPlayerRow.children('.actions').remove();
    $(this.$addedPlayerRow.children()[0]).html('')

    var modalContent = this.template({
      players: this.collection,
      addedPlayerRow: this.$addedPlayerRow.html()
    });

    this.$el.html(modalContent);
    return this;
  }
})