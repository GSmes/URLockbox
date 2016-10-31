function prependRow(link) {
  var buttonText = link.read ? 'Mark as Unread' : 'Mark as Read';
  var rowStyle = link.read ? 'readStyle' : 'unreadStyle';

  $("#table-body").prepend(
    "<tr class='" + rowStyle + "' id='link-"+ link.id +"'>" +
      "<td contenteditable='true' class='title input' id=title-" + link.id + ">" +
        link.title +
      "</td>" +

      "<td contenteditable='true' class='input' id=url-" + link.id + ">" +
        link.url +
      "</td>" +

      "<td class='status' id='read-status-" + link.id + "'>" +
        link.read +
      "</td>" +

      "<td class='update'>" +
        "<center>" +
          "<div read-status='" + link.read + "'" +
            "<button type='button' class='update-status btn btn-md btn-default' id='" + link.id + "'>" +
              buttonText +
            "</button>" +
          "</div>" +
        "</center>" +
      "</td>" +
    "</tr>"
  );
}

function clearFields() {
  $("#titleField").val("");
  $("#urlField").val("");
}
