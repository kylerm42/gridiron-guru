FantasyFootball.Views.TeamShow = Backbone.View.extend({
  initialize: function (options) {
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.collection, 'sync', this.render);
    // this.listenTo(this.collection, 'change', this.updateRosterSpots);
    // this.listenTo(this.collection, 'remove', this.removeRosterRow);
    // this.listenTo(this.collection, 'sync', this.addRosterRows);
    // this.model.rosterSpots().each(this.addRosterRow.bind(this))
  },

  template: JST['teams/show'],

  events: {
    'sort': 'setPlaceholder',
    'click .drop-player': 'dropPlayer',
    'click .trade-sent-btn': 'sentTradeOpen',
    'click .trade-received-btn': 'receivedTradeOpen',
    'drop': 'swapRosterSpot'
  },

  render: function () {
    console.log('rendering team show')
    var renderedContent = this.template({
      team: this.model,
      rosterSpots: this.collection
    });
    this.$el.html(renderedContent);

    // for keeping row width when dragging
    var fixHelper = function(ui) {
      console.log($(ui.currentTarget).children())
      console.log(this)
    	$(ui.currentTarget).children().each(function() {
        console.log(this)
    		$(this).width($(this).width());
    		$(this).height($(this).height());
    	});
    	return ui.currentTarget;
    };

    $('tbody tr[data-roster-spot]').draggable({
      containment: 'parent',
      distance: 15,
      axis: 'y',
      helper: 'clone',
      opacity: 0.75,
      revert: 'invalid',
      revertDuration: 250,
    });

    $('tbody tr[data-roster-spot]').droppable({
      accept: this.rosterDropAccept,
      activeClass: 'darker',
      hoverClass: 'info',
      tolerance: 'pointer'
    })

    return this;
  },

  rosterDropAccept: function (ui) {
    if ($(this).data('roster-spot') === 'BN') {
      if (ui.data('roster-spot') === $(this).data('position')) {
        return true;
      } else if (ui.data('roster-spot') === 'R/W/T') {
        if ($(this).data('position') === 'RB' || $(this).data('position') === 'WR'
            || $(this).data('position') === 'TE') {
          return true;
        };
      };
    };
    if ($(this).data('roster-spot') === 'R/W/T') {
      if (ui.data('roster-spot') === 'BN') {
        return (ui.data('position') === 'RB' || ui.data('position') === 'WR' ||
                ui.data('position') === 'TE')
      } else {
        return (ui.data('position') === $(this).data('position'));
      };
    }
    return $(this).data('roster-spot') === ui.data('position');
  },

  swapRosterSpot: function (event, dragged) {
    var $original = $(event.target);
    var $swapped = $(dragged.draggable[0]);

    var $placeholder = $('<tr><td></td></tr>');
    $swapped.after($placeholder);
    $original.after($swapped);
    $placeholder.replaceWith($original);

    var originalRosterSpot = this.collection.get($original.data('roster-id'));
    var swappedRosterSpot = this.collection.get($swapped.data('roster-id'));

    var tempPosition = originalRosterSpot.get('position');
    originalRosterSpot.set('position', swappedRosterSpot.get('position'));
    swappedRosterSpot.set('position', tempPosition);
    originalRosterSpot.unset('player');
    swappedRosterSpot.unset('player');

    originalRosterSpot.save();
    swappedRosterSpot.save();


    // var $newOriginal = $('<tr></tr>').html($swapped.html());
    // var $newSwapped = $('<tr></tr>').html($original.html());
    // $original.html($newOriginal.html());
    // $swapped.html($newSwapped.html());
    //
    // var originalRosterSpot = this.collection.get($original.data('roster-id'));
    // originalRosterSpot.set('player_id', $swapped.data('id'));
    //
    // var swappedRosterSpot = this.collection.get($swapped.data('roster-id'));
    // swappedRosterSpot.set('player_id', $original.data('id'));
    //
    // var tempPlayer = originalRosterSpot.player;
    // originalRosterSpot.player = swappedRosterSpot.player;
    // swappedRosterSpot.player = tempPlayer;
    //
    // $original.attr('data-id', originalRosterSpot.get('player_id'));
    // $swapped.attr('data-id', swappedRosterSpot.get('player_id'));
    //
    // var tempPosition = $original.data('position');
    // $original.attr('data-position', $swapped.data('position'));
    // $swapped.attr('data-position', tempPosition);
    //
    // $original.children().first().text($original.data('roster-spot'));
    // $swapped.children().first().text($swapped.data('roster-spot'));
  },

  updateRosterSpots: function (event) {
    this.render();
  },

  addRosterRow: function (rosterSpot) {
    var rosterRowView = new FantasyFootball.Views.RosterRow({
      model: rosterSpot,
      team: this.model
    });
    this.addSubview('tbody', rosterRowView);
    rosterRowView.render();
  },

  addRosterRows: function (rosterSpots) {
    var view = this;
    rosterSpots.forEach(function (rosterSpot) {
      view.addRosterRow(rosterSpot);
    })
  },

  removeRosterRow: function (rosterSpot) {
    var rosterRowView = _(this.subviews()["tbody"]).find(function (subview) {
      return subview.model == rosterSpot;
    });

    this.removeSubview("tbody", rosterRowView);
  },

  dropPlayer: function (event) {
    var $currentTarget = $(event.currentTarget);
    this.droppedPlayerId = $(event.currentTarget).data('id');
    var droppedPlayerName = $currentTarget.data('name');

    var $confirm = $('<button>').addClass('btn btn-danger pull-right drop-confirm')
                                .attr('id', 'drop-' + this.droppedPlayerId)
                                .attr('data-id', this.droppedPlayerId)
                                .text('Confirm');
    var $cancel = $('<button>').addClass('btn btn-default drop-cancel')
                               .attr('data-id', this.droppedPlayerId)
                               .text('Cancel');
    var $buttons = $('<div>').append($cancel).append($confirm);
    $(event.currentTarget).popover({
      html: true,
      title: "Are you sure you want to drop " + droppedPlayerName + "?",
      content: $buttons,
      trigger: 'manual'
    });

    $currentTarget.popover('toggle');

    $('.drop-cancel').on('click', this.dropCancel.bind(this));
    $('.drop-confirm').on('click', this.dropConfirm.bind(this))
  },

  dropConfirm: function (event) {
    console.log('confirming drop')
    var $currentTarget = $(event.currentTarget);
    $currentTarget.attr('disabled', 'disabled').text('Dropping...');
    var playerId = $currentTarget.data('id');

    var addDrop = new FantasyFootball.Models.AddDrop({
      dropped_player_id: playerId,
      team_id: this.model.id
    })

    addDrop.save({}, {
      success: function (resp) {
        $('.drop-player').popover('hide')
        $('#player-' + playerId).remove();
      }
    });
  },

  dropCancel: function (event) {
    var popoverId = $(event.currentTarget).data('id')
    $('#drop-' + popoverId).popover('hide')
  },

  sentTradeOpen: function (event) {
    var $currentTarget = $(event.currentTarget);
    this.openTrade = this.model.sentTrades().get($currentTarget.data('id'));

    var tradeSentModalView = new FantasyFootball.Views.TeamTradeSentModal({
      model: this.openTrade
    });

    $('#trade-modal .modal-content').html(tradeSentModalView.render().$el);

    $('.confirm-btn').off();
    $('.confirm-btn').on('click', this.sentTradeCancel.bind(this));
  },

  sentTradeCancel: function (event) {
    var view = this;
    $('.confirm-btn').attr('disabled', 'disabled').text("Cancelling...");

    this.openTrade.destroy({
      success: function () {
        $('#trade-modal').modal('hide');
        view.model.sentTrades().remove(view.openTrade);
        $('.trade-sent-btn[data-id="' + view.openTrade.id + '"').parent()
                                                                .alert('close')
      }
    });
  },

  receivedTradeOpen: function (event) {
    var $currentTarget = $(event.currentTarget);
    this.openTrade = this.model.receivedTrades().get($currentTarget.data('id'));

    var tradeReceivedModalView = new FantasyFootball.Views.TeamTradeReceivedModal({
      model: this.openTrade
    });

    $('#trade-modal .modal-content').html(tradeReceivedModalView.render().$el);

    $('.accept-btn').off();
    $('.accept-btn').on('click', this.receivedTradeAccept.bind(this));
    $('.deny-btn').off();
    $('.deny-btn').on('click', this.receivedTradeDeny.bind(this));
  },

  receivedTradeAccept: function (event) {
    $('.deny-btn').attr('disabled', 'disabled');
    $('.accept-btn').attr('disabled', 'disabled').text("Accepting...");
    this.openTrade.set('status', 'accepted');
    this.openTrade.save({}, {
      success: function () {
        console.log('success');
        $('#trade-modal').modal('hide');
      }
    });
  },

  receivedTradeDeny: function (event) {
    var view = this;
    $('.deny-btn').attr('disabled', 'disabled').text("Cancelling...");

    this.openTrade.destroy({
      success: function () {
        $('#trade-modal').modal('hide');
        view.model.receivedTrades().remove(view.openTrade);
        $('.trade-received-btn[data-id="' + view.openTrade.id + '"').parent()
                                                                .alert('close')
      }
    });
  },

  setPlaceholder: function (event, ui) {
    $('.ui-sortable-placeholder').height('55px')
  }
});

FantasyFootball.Views.RosterRow = Backbone.View.extend({
  initialize: function (options) {
    this.model = options.model;
    this.team = options.team;
  },

  tagName: 'tr',
  template: JST['teams/roster_row'],

  render: function () {
    var renderedContent = this.template({
      position: this.model.get('position'),
      player: this.model.player,
      team: this.team
    });

    this.$el.addClass('full-width').attr('id', 'player-' + this.model.player.id).html(renderedContent);
    return this;
  }
})