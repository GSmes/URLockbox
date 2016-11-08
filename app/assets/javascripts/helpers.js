function prependRow(link) {
  var buttonText = link.read ? 'Mark as Unread' : 'Mark as Read';
  var rowStyle = link.read ? 'readStyle' : 'unreadStyle';

  $("#table-body").prepend(
    "<tr class='" + rowStyle + "' id='link-"+ link.id +"'>" +
      "<td contenteditable='false' class='titleInput search' id=title-" + link.id + ">" +
        link.title +
      "</td>" +

      "<td contenteditable='false' class='urlInput search' id=url-" + link.id + ">" +
        "<a href='" + link.url + "'>" +
          link.url +
        "</a>" +
      "</td>" +

      "<td class='status' id='read-status-" + link.id + "'>" +
        link.read +
      "</td>" +

      "<td class='update'>" +
        "<center>" +
          "<div read-status='" + link.read + "'" +
            "<button type='button' class='update-status btn btn-md btn-primary' id='" + link.id + "'>" +
              buttonText +
            "</button>" +
          "</div>" +
        "</center>" +
      "</td>" +

      "<td class='edit'>" +
        "<button type='button' class='edit-link btn btn-md btn-default' id='" + link.id + "'>Edit</button>" +
      "</td>" +
    "</tr>"
  );
}

function flashAlert(error) {
  $("#linkWell").append(
    "<div class='alert alert-danger alert-dismissable text-center animated shake' role='alert'>" +
      "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>" +
        "<span aria-hidden='true'>&times;</span>" +
      "</button>" + error +
    "</div>"
  );
}

function clearFields() {
  $("#titleField").val("");
  $("#urlField").val("");
}
