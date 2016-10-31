$(document).ready(function() {
  getLinks();
  createLink();
  updateLinkStatus();
});

function getLinks() {
  $.getJSON('/api/v1/links')
    .done(function(response) {
      response.forEach(function(link) {
        prependRow(link);
      });
    })
    .fail(function(error) {
      console.log(error);
    });
}

function createLink() {
  $("#submitLink").on('click', function(e) {
    e.preventDefault();
    var newData = $("#newLink").serialize();

    $.ajax({
      url: "/api/v1/links",
      type: "POST",
      dataType: "JSON",
      data: newData,
      success: function(response) {
        prependRow(response);
        clearFields();
      },
      error: function(error) {
        console.log(error);
      }
    });
  });
}

function updateLinkStatus() {
  $("#linksTable").on('click', '.update-status', function(e) {
    var target = e.currentTarget;
    var linkId = target.id;
    var currentStatus = $(target).attr('read-status');
    var updatedStatus = currentStatus === 'false' ? true : false;
    var statusParams = { read: updatedStatus };

    $.ajax({
      url: "/api/v1/links/" + linkId,
      type: "PATCH",
      dataType: "JSON",
      data: statusParams,
      success: function(response) {
        $(target).attr('read-status', updatedStatus);
        $(target).closest("td").prev().text(updatedStatus);
        $(target).closest("tr").toggleClass('readStyle');
        $(target).closest("tr").toggleClass('unreadStyle');
      },
      error: function(error) {
        console.log(error);
      }
    });
  });
}
