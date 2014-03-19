FantasyFootball.Views.TeamShow = Backbone.CompositeView.extend({
  initialize: function (options) {
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.collection, 'add', this.addPlayer)
  },

  template: JST['teams/show'],

  events: {
    "sort": "setPlaceholder"
  },

  render: function () {
    console.log('rendering team show')
    var renderedContent = this.template({ team: this.model });
    this.$el.html(renderedContent);
    this.renderSubviews();

    var fixHelper = function(e, ui) {
    	ui.children().each(function() {
    		$(this).width($(this).width());
    		$(this).height($(this).height());
    	});
    	return ui;
    };

    $("tbody").sortable({
      containment: 'parent',
      distance: 10,
      revert: 250,
      opacity: 0.7,
      helper: fixHelper,
      forcePlaceholderSize: true,
      tolerance: 'pointer'
    });
    return this
  },

  addPlayer: function (player) {
    var playerRowView = new FantasyFootball.Views.PlayerRow({ model: player });
    this.addSubview('tbody', playerRowView);
    playerRowView.render();
  },

  setPlaceholder: function (event, ui) {
    $('.ui-sortable-placeholder').height('55px')
  }
});

FantasyFootball.Views.PlayerRow = Backbone.View.extend({
  tagName: 'tr',
  template: JST['players/row'],

  render: function () {
    var renderedContent = this.template({ player: this.model });

    this.$el.addClass('full-width').html(renderedContent);
    return this;
  }
})