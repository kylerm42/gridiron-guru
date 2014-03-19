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
    "click .add-player": 'addPlayer'
  }, Backbone.TableView.prototype.events),

  render: function () {
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
    })

    $('#addDropModal .modal-body').html("<h3>Testing some things</h3><br>All of your players go here")

    // addDrop.save({
    //   success: function (resp) {
    //     console.log('success')
    //     window.location('/#/leagues/' + that.league.id + '/teams/' + resp.team_id);
    //   }
    // });
  }
});