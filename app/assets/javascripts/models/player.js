FantasyFootball.Models.Player = Backbone.Model.extend({
  urlRoot: '/api/players',

  get_name: function () {
    return this.get('first_name') + ' ' + this.get('last_name');
  },

  points: function () {
    var passYards = this.get('pass_yards') / 25;
    var passTDs = this.get('pass_tds') * 4;
    var passInts = this.get('pass_ints') * -2;
    var rushYards = this.get('rush_yards') / 10;
    var rushTDs = this.get('rush_tds') * 6;
    var recYards = this.get('rec_yards') / 10;
    var recTDs = this.get('rec_tds') * 6;
    var twoPtConv = this.get('two_pt_conv') * 2;
    var fumbles = this.get('fumbles') * -2;

    return passYards + passTDs + passInts + rushYards + rushTDs + recYards + recTDs + twoPtConv + fumbles;
  }
})