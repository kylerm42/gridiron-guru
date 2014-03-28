FantasyFootball.Views.PlayersIndexRow = Backbone.View.extend({
  tagName: 'tr',
  template: JST['players/row'],

  render: function () {
    var renderedContent = this.template({ player: this.model });

    this.$el.html(renderedContent);
    return this;
  }
});

FantasyFootball.Views.PlayersIndex = Backbone.CompositeView.extend({
  initialize: function (options) {
    this.positions = 'all';
    this.page = 1
    this.week = 'all';
    this.availability = 'available';
    this.collection = options.collection;
    this.league = options.league;
    this.currentTeam = FantasyFootball.teams.findWhere({
      league_id: +options.league.id,
      user_id: +FantasyFootball.currentUser.id
    });

    this.listenTo(this.league, 'sync', this.render);
    // this.listenTo(this.collection, 'add', this.addPlayerRow);
    this.listenTo(this.collection, 'sync', this.addPlayerRows);
    this.listenTo(this.currentTeam.players(), 'add remove sync', this.render)
  },

  template: JST['players/index'],

  events: {
    'click .add-player': 'addPlayer',
    'click .drop-player': 'dropPlayer',
    'click .trade-player': 'tradePlayer',
    'click .pos-select': 'positionSelect',
    'click .avail-select': 'availSelect',
    'click #next-page': 'nextPage',
    'click #prev-page': 'prevPage'
  },

  render: function () {
    console.log('rendering player index');
    this.collection.sort();
    var renderedContent = this.template({
      players: this.collection,
      league: this.league
    });

    this.$el.html(renderedContent);
    this.renderSubviews();

    $('.btn-group input[data-position="' + this.positions + '"]').parent().addClass('active');
    $('.btn-group input[data-avail="' + this.availability + '"]').parent().addClass('active');

    return this;
  },

  positionSelect: function (event) {
    var view = this;
    $currentTarget = $(event.currentTarget);
    this.positions = $currentTarget.children('input').data('position');
    console.log(this.positions)
    $('tbody tr').remove();
    $loadRow = $('<td></td>').attr('colspan', '13').addClass('centered')
                             .text("Loading players...")
    $('tbody').append($('<tr>').html($loadRow))
    this.collection.fetch({
      data: { positions: this.positions },
      reset: true,
      success: function () {
        $('tbody').empty()
      }
    });
  },

  availSelect: function (event) {

  },

  nextPage: function (event) {
    console.log('called')
    this.page++
    $('tbody tr').remove();
    $loadRow = $('<td></td>').attr('colspan', '13').addClass('centered')
                             .text("Loading players...")
    $('tbody').append($('<tr>').html($loadRow))
    this.collection.fetch({
      data: { page: this.page, positions: this.positions },
      reset: true,
      success: function () {
        $('tbody').empty()
      }
    })
  },

  prevPage: function (event) {

  },

  addPlayerRow: function (player) {
    var playerRowView = new FantasyFootball.Views.PlayersIndexRow({
      model: player
    });
    this.addSubview('tbody', playerRowView);
    playerRowView.render();
  },

  addPlayerRows: function (players) {
    var view = this;
    players.forEach(function (player) {
      view.addPlayerRow(player);
    });
  },

  addPlayer: function (event) {
    var $currentTarget = $(event.currentTarget);
    var addedPlayerId = $currentTarget.data('id');
    $('#player-action-modal #modal-title').text("Choose player to drop:")
    $('.confirm-btn').off();
    $('.confirm-btn').attr('id', 'add-confirm').text("Add Player")

    this.addDrop = new FantasyFootball.Models.AddDrop({
      added_player_id: addedPlayerId,
      team_id: this.currentTeam.id
    });

    var modalView = new FantasyFootball.Views.PlayersAddDropModal({
      addedPlayerRow: $('<tr>').html($currentTarget.closest('tr').html()),
      collection: this.currentTeam.rosterSpots()
    });

    $('#add-confirm').on('click', this.addConfirm.bind(this));
    $('#player-action-modal .modal-body').html(modalView.render().$el);
  },

  addConfirm: function (event) {
    var view = this;
    var droppedPlayerId = $('input:checked').val();

    if (droppedPlayerId) {
      $('#add-confirm').attr('disabled', 'disabled').text('Adding player...');
      this.addDrop.set('dropped_player_id', droppedPlayerId);
      this.addDrop.save({}, {
        success: function () {
          alertify.log("Successfully added a player!", 'success', 3000)
          $('#player-action-modal').modal('hide');
          $('.modal-backdrop').remove();
          $('body').removeClass('modal-open');
          Backbone.history.navigate('#/leagues/' + view.league.id + '/teams/' + view.currentTeam.id);

          var droppedPlayer = view.currentTeam.players().get(droppedPlayerId);
          view.currentTeam.players().remove(droppedPlayer);
          var addedPlayer = view.collection.get(view.addDrop.get('added_player_id'));
          view.currentTeam.players().add(addedPlayer);
        }
      });
    } else {
      alertify.log("You must select a player to drop", 'error', 3000);
    }
  },

  dropPlayer: function (event) {
    var $currentTarget = $(event.currentTarget);
    var droppedPlayerId = $currentTarget.data('id');
    var droppedPlayerName = $currentTarget.data('name');

    var $confirm = $('<button>').addClass('btn btn-danger pull-right drop-confirm')
                                .attr('id', 'drop-' + droppedPlayerId)
                                .attr('data-id', droppedPlayerId)
                                .text('Confirm');
    var $cancel = $('<button>').addClass('btn btn-default drop-cancel')
                               .attr('data-id', droppedPlayerId)
                               .text('Cancel');
    var $buttons = $('<div>').append($cancel).append($confirm);
    $currentTarget.popover({
      html: true,
      title: "Are you sure you want to drop " + droppedPlayerName + "?",
      content: $buttons,
      trigger: 'manual'
    });

    $currentTarget.popover('toggle');

    $('.drop-confirm').off();
    $('.drop-confirm').on('click', this.dropConfirm.bind(this));
    $('.drop-cancel').on('click', this.dropCancel.bind(this));
  },

  dropConfirm: function (event) {
    console.log('confirming drop');
    var view = this;
    var $currentTarget = $(event.currentTarget);

    $currentTarget.attr('disabled', 'disabled').text('Dropping...');
    var playerId = $currentTarget.data('id');
    var addDrop = new FantasyFootball.Models.AddDrop({
      dropped_player_id: playerId,
      team_id: this.currentTeam.id
    })

    addDrop.save({}, {
      success: function (resp) {
        var droppedPlayer = view.currentTeam.players().get(playerId);
        view.currentTeam.players().remove(droppedPlayer);

        $('.drop-player').popover('hide')
        $dropButton = $('#drop-' + playerId);
        $addButton = $('<button>').addClass('add-player btn btn-success btn-xs')
                                  .attr('data-id', playerId)
                                  .attr('data-toggle', 'modal')
                                  .attr('data-target', '#addDropModal');
        $plusIcon = $('<span>').addClass('glyphicon glyphicon-plus-sign');
        $addButton.html($plusIcon);
        var droppedPlayer = view.currentTeam.rosterSpots().get(resp);
        view.currentTeam.rosterSpots().remove(droppedPlayer);

        $addButton.insertBefore($dropButton)
        $dropButton.remove();
      }
    });
  },

  dropCancel: function (event) {
    var popoverId = $(event.currentTarget).data('id')
    $('.drop-player[data-id="' + popoverId + '"]').popover('hide')
  },

  tradePlayer: function (event) {
    console.log('trading player');
    var $currentTarget = $(event.currentTarget);
    var tradePlayer = this.collection.get($currentTarget.data('id'));
    this.tradeTeam = FantasyFootball.teams.getOrFetch(tradePlayer.get('team').id)

    this.trade = new FantasyFootball.Models.Trade({
      league_id: this.league.id,
      sender_id: this.currentTeam.id,
      receiver_id: this.tradeTeam.id
    })

    $('#player-action-modal #modal-title').text("Choose players to trade for:")
    $('.confirm-btn').off();
    $('.confirm-btn').attr('id', 'trade-continue').text("Continue")

    var tradeReceiveModalView = new FantasyFootball.Views.PlayersTradeReceiveModal({
      model: this.tradeTeam,
      tradePlayer: tradePlayer,
      currentTeam: this.currentTeam
    });

    $('#player-action-modal .modal-body').html(tradeReceiveModalView.render().$el);
    $('#trade-continue').on('click', this.tradeContinue.bind(this));
  },

  tradeContinue: function (event) {
    console.log('continuing trade');
    var view = this;
    var tradePlayers = $('input:checked');

    if (tradePlayers.length > 0) {
      var tradeForIds = [];
      this.tradeForRows = [];
      tradePlayers.each(function (i, input) {
        tradeForIds.push(+$(input).val());
        view.tradeForRows.push($('<tr>').html($(input).closest('tr').html()));
      });
      this.tradeForRows.forEach(function (row, idx) {
        $($(row).children('td')[0]).empty();
      });

      this.trade.set('trade_receive_player_ids', tradeForIds);

      $('#player-action-modal #modal-title').text("Choose players to trade away:");
      $('.confirm-btn').off();
      $('.confirm-btn').attr('id', 'trade-complete');

      var tradeSendModalView = new FantasyFootball.Views.PlayersTradeSendModal({
        model: this.currentTeam,
        getPlayerRows: this.tradeForRows,
        otherTeam: this.tradeTeam
      });

      $('#player-action-modal .modal-body').html(tradeSendModalView.render().$el);
      $('#trade-complete').on('click', this.tradeComplete.bind(this));
    } else {
      alertify.log("You must select at least one player", 'error', 3000);
    }
  },

  tradeComplete: function (event) {
    console.log('completing trade');
    var tradePlayers = $('input:checked');

    if (tradePlayers.length > 0) {
      var tradeAwayIds = [];
      var tradeAwayRows = [];
      tradePlayers.each(function (i, input) {
        tradeAwayIds.push(+$(input).val());
        tradeAwayRows.push($('<tr>').html($(input).closest('tr').html()));
      });
      tradeAwayRows.forEach(function (row, idx) {
        $($(row).children('td')[0]).empty();
      });

      this.trade.set('trade_send_player_ids', tradeAwayIds);

      $('#player-action-modal #modal-title').text("Review your trade:");
      $('.confirm-btn').off();
      $('.confirm-btn').attr('id', 'trade-confirm').text("Submit trade");

      var tradeConfirmModalView = new FantasyFootball.Views.PlayersTradeConfirmModal({
        tradeForRows: this.tradeForRows,
        tradeAwayRows: tradeAwayRows,
        team: this.currentTeam,
        otherTeam: this.tradeTeam
      });

      $('#player-action-modal .modal-body').html(tradeConfirmModalView.render().$el);
      $('#trade-confirm').on('click', this.tradeConfirm.bind(this));
    } else {
      alertify.log("You must select at least one player", 'error', 3000);
    }
  },

  tradeConfirm: function (event) {
    $('#trade-confirm').attr('disabled', 'disabled').text('Submitting...');

    this.trade.save({}, {
      success: function () {
        console.log('trade sent!');
        alertify.log("Trade sent!", 'success', 3000);
        $('#player-action-modal').modal('hide');
        $('.confirm-btn').removeAttr('disabled');
      }
    });
  }
});