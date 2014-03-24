FantasyFootball.Collections.RosterSpots = Backbone.Collection.extend({
  url: '/api/roster_spots',
  model: FantasyFootball.Models.RosterSpot,

  rosterValues: {
    'QB': 1,
    'RB': 2,
    'WR': 3,
    'TE': 4,
    'K': 5,
    'DEF': 6
  },

  benchPlayers: function () {
    var rosterSpots = this;
    var benchPlayers = this.where({ position: 'BN' });
    var filteredBench = benchPlayers.filter(function(rosterSpot) {
      var position = rosterSpot.player.get('position');
      return position !== 'K' && position !== 'DEF'
    });
    var sortedBench = filteredBench.sort(function (rs1, rs2) {
      rosterSpots.rosterValues[rs1.player.get('position')] -
      rosterSpots.rosterValues[rs2.player.get('position')]
    });
    return sortedBench;
  },

  startingQB: function () {
    return this.where({ position: 'QB' });
  },

  startingRB: function () {
    return this.where({ position: 'RB' });
  },

  startingWR: function () {
    return this.where({ position: 'WR' });
  },

  startingTE: function () {
    return this.where({ position: 'TE' });
  },

  startingRWT: function () {
    return this.where({ position: 'R/W/T' });
  },

  startingK: function () {
    return this.where({ position: 'K' });
  },

  benchK: function () {
    var rosterSpots = this;
    var benchPlayers = this.where({ position: 'BN' });
    var filteredBench = benchPlayers.filter(function(rosterSpot) {
      var position = rosterSpot.player.get('position');
      return position === 'K'
    });
    return filteredBench;
  },

  startingDEF: function () {
    return this.where({ position: 'DEF' });
  },

  benchDEF: function () {
    var rosterSpots = this;
    var benchPlayers = this.where({ position: 'BN' });
    var filteredBench = benchPlayers.filter(function(rosterSpot) {
      var position = rosterSpot.player.get('position');
      return position === 'DEF'
    });
    return filteredBench;
  },

  getOrFetch: function (id) {
    var model;
    var rosterSpots = this;

    if (model = this.get(id)) {
      model.fetch();
      return model;
    } else {
      model = new FantasyFootball.Models.Player({ id: id });
      model.fetch({
        success: function () { rosterSpots.add(model) }
      });

      return model;
    }
  },
});