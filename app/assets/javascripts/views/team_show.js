FantasyFootball.Views.TeamShow = Backbone.CompositeView.extend({
  initialize: function (options) {
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.collection, 'add', this.addPlayer)
  },

  template: JST['teams/show'],

  render: function () {
    console.log('rendering team show')
    var renderedContent = this.template({ team: this.model });
    this.$el.html(renderedContent);
    this.renderSubviews();
    return this
  },

  addPlayer: function (player) {
    var playerRowView = new FantasyFootball.Views.PlayerRow({ model: player });
    this.addSubview('tbody', playerRowView);
    playerRowView.render();
  }
});

FantasyFootball.Views.PlayerRow = Backbone.View.extend({
  tagName: 'tr',
  template: JST['players/row'],

  render: function () {
    var renderedContent = this.template({ player: this.model });

    this.$el.html(renderedContent);
    return this;
  }
})