$(document).ready(function() {
  getLinks();
  createLink();
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
