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

  events: _.extend({
    "click .add-player": 'addPlayer',
    "click .drop-player": 'dropPlayer'
  }, Backbone.TableView.prototype.events),

  render: function () {
    console.log("rendering players index")
    var renderedContent = this.template({
      players: this.collection,
      league: this.league
    });

    this.$el.html(renderedContent);
    this.renderSubviews();

    return this;
  },

  addPlayer: function (event) {
    var $currentTarget = $(event.currentTarget);
    var playerId = $currentTarget.data('id');
    var that = this;

    var addDrop = new FantasyFootball.Models.AddDrop({
      added_player_id: playerId,
      league_id: this.league.id
    });

    var modalView = new FantasyFootball.Views.TeamAddDropModal({
      addedPlayerRow: $('<tr>').html($currentTarget.closest('tr').html()),
      collection: this.collection.currentTeam.get('players')
    });

    $('#addDropModal .modal-body').html(modalView.render().$el);

    // addDrop.save({
    //   success: function (resp) {
    //     console.log('success')
    //     window.location('/#/leagues/' + that.league.id + '/teams/' + resp.team_id);
    //   }
    // });
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
    console.log('confirming drop')
    var $currentTarget = $(event.currentTarget);
    $currentTarget.attr('disabled', 'disabled').text('Dropping...');
    var playerId = $currentTarget.data('id');

    var addDrop = new FantasyFootball.Models.AddDrop({
      dropped_player_id: playerId,
      league_id: this.league.id
    })

    debugger
    addDrop.save({}, {
      success: function (resp) {
        $('.drop-player').popover('hide')
        $dropButton = $('#drop-' + playerId);
        $addButton = $('<button>').addClass('add-player btn btn-default btn-xs')
                                  .attr('data-id', playerId)
                                  .attr('data-toggle', 'modal')
                                  .attr('data-target', '#addDropModal');
        $plusIcon = $('<span>').addClass('glyphicon glyphicon-plus-sign text-success');
        $addButton.html($plusIcon);

        $addButton.insertBefore($dropButton)
        $dropButton.remove();
      }
    });
  },

  dropCancel: function (event) {
    var popoverId = $(event.currentTarget).data('id')
    $('#drop-' + popoverId).popover('hide')
  }
});



