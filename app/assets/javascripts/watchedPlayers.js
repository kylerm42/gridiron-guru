$(function() {

  $('.watch-player.add').on('click', function(e) {
    e.preventDefault();
    console.log("clicked add");
    var $watchLink = $(e.currentTarget);
    var url = $watchLink.attr('href');
    var watchedPlayer = {
      player_id: $watchLink.attr("data-id"),
    }

    $.ajax({
      url: url,
      type: 'POST',
      data: watchedPlayer,
      success: function() {
        console.log("success add")
        $watchLink.addClass('remove').removeClass('add')
        $watchLink.children().addClass('icon-eye-close').removeClass('icon-eye-open')
      }
    })
  })

  $('.watch-player.remove').on('click', function(e) {
    e.preventDefault();
    console.log("clicked remove");
    var $watchLink = $(e.currentTarget);
    var url = $watchLink.attr('href');

    $.ajax({
      url: url,
      type: 'DELETE',
      success: function() {
        console.log("success remove")
        $watchLink.addClass('add').removeClass('remove')
        $watchLink.children().addClass('icon-eye-open').removeClass('icon-eye-close')
      }
    })
  })

})