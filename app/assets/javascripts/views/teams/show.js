FantasyFootball.Views.TeamShow = Backbone.View.extend({
  initialize: function (options) {
    this.week = 'all';
    this.listenTo(this.model, 'sync change', this.render);
    this.listenTo(this.model.receivedTrades(), 'remove', this.render);
    this.listenTo(this.model.sentTrades(), 'remove', this.render);
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
    'click .trade-player': 'tradePlayer',
    'click .trade-sent-btn': 'sentTradeOpen',
    'click .trade-received-btn': 'receivedTradeOpen',
    'click .week-select': 'weekUpdate',
    'drop': 'swapRosterSpot'
  },

  render: function () {
    console.log('rendering team show')
    if (this.model.matchup) {
      if (this.model.matchup.get('home_team_id') === this.model.id) {
        var opponent = this.model.matchup.get('away_team');
      } else {
        var opponent = this.model.matchup.get('home_team');
      };
    };
    var renderedContent = this.template({
      team: this.model,
      matchup: this.model.matchup,
      opponent: opponent,
      rosterSpots: this.collection
    });
    this.$el.html(renderedContent);

    $('.btn-group input[data-week-id="' + this.week + '"]').parent().addClass('active');

    // for keeping row width when dragging
    var fixHelper = function(ui) {
      var $target = $(ui.currentTarget)
      var $newRow = $('<tr></tr>').html($target.html());
      $newRow.width($target.width());
      var children = $target.children();

    	$newRow.children().each(function(i, child) {
        $(child).width($(children[i]).width() + +$(children[i]).css('padding')[0] * 2)
                .css('padding', '8px');
    	});
    	return $newRow;
    };

    if (this.model.get('user_id') === FantasyFootball.currentUser.id) {
      $('tbody tr[data-roster-spot]').draggable({
        appendTo: 'parent',
        containment: 'parent',
        distance: 15,
        axis: 'y',
        helper: fixHelper,
        opacity: 0.75,
        revert: false,
        revertDuration: 250,
      });

      $('tbody tr[data-roster-spot]').droppable({
        accept: this.rosterDropAccept,
        activeClass: 'darker',
        hoverClass: 'info',
        tolerance: 'pointer'
      });
    };
    return this;
  },

  tradePlayer: function (event) {
    console.log('trading player');
    var $currentTarget = $(event.currentTarget);
    var tradePlayer = this.collection.get($currentTarget.data('id'));


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
    } else {
      if (ui.data('roster-spot') !== 'BN' && ui.data('roster-spot') === $(this).data('roster-spot')) {
        return false
      }
    }
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

    originalRosterSpot.save({}, {
      success: function () {
        alertify.log("Roster saved successfully!", "success", 2000);
      }
    });
    swappedRosterSpot.save();
  },

  weekUpdate: function (event) {
    var $currentTarget = $(event.currentTarget);
    this.week = $currentTarget.children('input').data('week-id')

    var playerIds = [];
    this.collection.each(function (rosterSpot) {
      playerIds.push(rosterSpot.player.id);
    });

    this.collection.fetch({
      data: {
        week: this.week,
        players: playerIds,
        team_id: this.model.id
      }
    })
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
    var view = this;
    var $currentTarget = $(event.currentTarget);
    $currentTarget.attr('disabled', 'disabled').text('Dropping...');
    var playerId = $currentTarget.data('id');
    var player = this.collection.get(playerId);

    var addDrop = new FantasyFootball.Models.AddDrop({
      dropped_player_id: playerId,
      team_id: this.model.id
    })

    addDrop.save({}, {
      success: function (resp) {
        $('.drop-player').popover('hide')
        $('tr[data-id="' + playerId + '"]').remove();
        view.collection.remove(player);
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
        debugger
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