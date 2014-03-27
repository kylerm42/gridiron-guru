FantasyFootball.Models.Player = Backbone.Model.extend({
  initialize: function() {
    this.set('points', this.points());
  },

  urlRoot: '/api/players',

  fullName: function () {
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
    var madePAT = this.get('made_pat');
    var missPAT = this.get('miss_pat') * -1;
    var made20 = this.get('made_20') * 2;
    var miss20 = this.get('miss_20') * -1;
    var made30 = this.get('made_30') * 2;
    var miss30 = this.get('miss_30') * -1;
    var made40 = this.get('made_40') * 3;
    var miss40 = this.get('miss_40') * -1;
    var made50 = this.get('made_50') * 4;
    var miss50 = this.get('miss_50') * -1;
    var made50Plus = this.get('made_50_plus') * 5;
    var sacks = this.get('sacks');
    var interceptions = this.get('interceptions') * 2;
    var fumRec = this.get('fum_rec') * 2;
    var safeties = this.get('safeties') * 2;
    var defTDs = this.get('def_tds') * 6;
    var retTDs = this.get('ret_tds') * 6;
    var points = this.get('pts_allowed');
    if (points === 0 && this.get('position') === 'DEF') { var ptsAllowed = 10 };
    if (points <= 6 && points > 0) { var ptsAllowed = 7 };
    if (points <= 13 && points > 6) { var ptsAllowed = 4 };
    if (points <= 20 && points > 13) { var ptsAllowed = 1 };
    if (points <= 27 && points > 20) { var ptsAllowed = 0 };
    if (points <= 34 && points > 27) { var ptsAllowed = -1 };
    if (points >= 35) { var ptsAllowed = -4 };

    this.set('points', passYards + passTDs + passInts + rushYards + rushTDs + recYards + recTDs + twoPtConv + fumbles + madePAT + missPAT + made20 + miss20 + made30 + miss30 + made40 + miss40 + made50 + miss50 + made50Plus + sacks + interceptions + fumRec + safeties + defTDs + retTDs + (ptsAllowed || 0));
    return this.get('points');
  }
});