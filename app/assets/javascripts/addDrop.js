$(function() {

  $('.add-player').on('click', function(e) {
    e.preventDefault();
    var $addLink = $(e.currentTarget);
    var url = $addLink.attr('href');
    var addedPlayer = {
      player_id: $addLink.attr("data-id"),
      type: "add"
    }

    $.ajax({
      url: url,
      type: 'POST',
      data: addedPlayer,
      success: function() {
        document.location = $addLink.attr('data-url');
      }
    })
  })

  $('.drop-player').on('click', function(e) {
    e.preventDefault();
    var $dropLink = $(e.currentTarget);
    var url = $dropLink.attr('href');
    var droppedPlayer = {
      player_id: $dropLink.attr("data-id"),
      type: "drop"
    }

    $.ajax({
      url: url,
      type: 'POST',
      data: droppedPlayer,
      success: function() {
        document.location = $dropLink.attr('data-url');
      }
    })
  })

})