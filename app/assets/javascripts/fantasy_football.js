window.FantasyFootball = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    FantasyFootball.currentUser = JSON.parse($('#current-user').html()).user;
    FantasyFootball.leagues = new FantasyFootball.Collections.Leagues();
    this.router = new FantasyFootball.Routers.AppRouter({
      $rootEl: $('div#content')
    });

    Backbone.history.start();
  }
};

Backbone.CompositeView = Backbone.View.extend({
  addSubview: function (selector, subview) {
    var selectorSubviews =
      this.subviews()[selector] || (this.subviews()[selector] = []);

    selectorSubviews.push(subview);

    var $selectorEl = this.$(selector);
    $selectorEl.append(subview.$el);
  },

  remove: function () {
    Backbone.View.prototype.remove.call(this);

    // remove all subviews as well
    _(this.subviews()).each(function (selectorSubviews, selector) {
      _(selectorSubviews).each(function (subview){
        subview.remove();
      });
    });
  },

  removeSubview: function (selector, subview) {
    var selectorSubviews =
      this.subviews()[selector] || (this.subviews()[selector] = []);

    var subviewIndex = selectorSubviews.indexOf(subview);
    selectorSubviews.splice(subviewIndex, 1);
    subview.remove();
  },

  renderSubviews: function () {
    var view = this;

    _(this.subviews()).each(function (selectorSubviews, selector) {
      var $selectorEl = view.$(selector);
      $selectorEl.empty();

      _(selectorSubviews).each(function (subview) {
        $selectorEl.append(subview.render().$el);
        subview.delegateEvents();
      });
    });
  },

  subviews: function () {
    if (!this._subviews) {
      this._subviews = {};
    }

    return this._subviews;
  }
});

Backbone.TableView = Backbone.CompositeView.extend({
  rowSubviewClass: null,

  events: {
    "click th": "resort"
  },

  initialize: function (options) {
    if (options) {
      this.league = options.league
      this.listenTo(this.league, 'sync', this.render)
    }

    this.sortFn = null;

    this.listenTo(this.collection, "add", this.addRowSubview);

    this.collection.each(this.addRowSubview.bind(this));
  },

  addRowSubview: function (model) {
    var rowSubview = new this.rowSubviewClass({
      model: model
    });

    this.addSubview("tbody", rowSubview);
    rowSubview.render();
  },

  resort: function (event) {
    var $currentTarget = $(event.currentTarget);
    if ($currentTarget.data("sort-col")) {
      this.sortFn = this._sortColFn($currentTarget.data("sort-col"));
    } else if ($currentTarget.data("sort-fn")) {
      this.sortFn = this[$currentTarget.data("sort-fn")];
    } else {
      return
    }

    this._sortRowSubviews();
    this.renderSubviews();
  },

  _sortRowSubviews: function () {
    var tableView = this;

    var rowSubviews = this.subviews()["tbody"];
    rowSubviews.sort(function (rowView1, rowView2) {
      var val1 = tableView.sortFn(rowView1.model);
      var val2 = tableView.sortFn(rowView2.model);

      if (val1 < val2) {
        return 1;
      } else if (val1 == val2) {
        return 0;
      } else {
        return -1;
      }
    });
  },

  _sortColFn: function (col) {
    return function (model) {
      return model.get(col);
    };
  }
});

$(FantasyFootball.initialize);