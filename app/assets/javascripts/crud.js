$(document).ready(function() {
  getLinks();
  createLink();
  updateLinkStatus();
  editLink();
  updateTitleText();
  updateUrlText();
  searchLinks();
  filterLinks();
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
        flashAlert(error.responseJSON.join(", "));
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
        var text = $(target).text();
        $(target).text(text == "Mark as Read" ? "Mark as Unread" : "Mark as Read");
      },
      error: function(error) {
        console.log(error);
      }
    });
  });
}

function editLink() {
  $("#linksTable").on('click', '.edit-link', function(e) {
    var target = e.currentTarget;

    $(target).prop('disabled', true);
    $(target).parent().prev().prev().prev().attr('contenteditable', 'true');
    $(target).parent().prev().prev().prev().prev().attr('contenteditable', 'true');
  });
}

function updateTitleText() {
  $("#linksTable").on('blur', '.titleInput', function(e) {
    var target = e.currentTarget;
    var linkId = target.id.replace(/^\D+/g, "");
    var title_id = "#title-" + linkId;
    var edit_data = { title: $(title_id).text() };

    $.ajax({
      url: "/api/v1/links/" + linkId,
      type: "PATCH",
      dataType: "JSON",
      data: edit_data,
      success: function(response) {
        $(title_id).text(response.title);
        $(target).attr('contenteditable', 'false');
        $(target).next().attr('contenteditable', 'false');
        $(target).next().next().next().next().children().prop('disabled', false);
      },
      error: function(error) {
        var errorData = error.responseJSON;

        flashAlert(errorData.errors.join(", "));
        $(title_id).text(errorData.link.title);
        console.log(error);
      }
    });
  });
}

function updateUrlText() {
  $("#linksTable").on('blur', '.urlInput', function(e) {
    var target = e.currentTarget;
    var linkId = target.id.replace(/^\D+/g, "");
    var url_id = "#url-" + linkId;
    var edit_data = { url: $(url_id).text() };

    $.ajax({
      url: "/api/v1/links/" + linkId,
      type: "PATCH",
      dataType: "JSON",
      data: edit_data,
      success: function(response) {
        $(url_id).text(response.url);
        $(target).attr('contenteditable', 'false');
        $(target).prev().attr('contenteditable', 'false');
        $(target).next().next().next().children().prop('disabled', false);
      },
      error: function(error) {
        var errorData = error.responseJSON;

        flashAlert(errorData.errors.join(", "));
        $(url_id).text(errorData.link.url);
        console.log(error);
      }
    });
  });
}
