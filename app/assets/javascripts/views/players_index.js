FantasyFootball.Views.PlayersIndexRow = Backbone.View.extend({
  tagName: 'tr',
  template: JST['players/row'],

  render: function () {
    var renderedContent = this.template({ player: this.model });

    this.$el.html(renderedContent);
    return this;
  }
});

FantasyFootball.Views.PlayersIndex = Backbone.TableView.extend({
  rowSubviewClass: FantasyFootball.Views.PlayersIndexRow,
  template: JST['players/index'],

  render: function () {
    var renderedContent = this.template({ players: this.collection });

    this.$el.html(renderedContent);
    this.renderSubviews();
    return this;
  }
});