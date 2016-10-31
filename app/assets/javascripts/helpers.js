function prependRow(link) {
  $("#table-body").prepend(
    "<tr id='link-"+ link.id +"'>" +
      "<td contenteditable='true' class='title input' id=title-" + link.id + ">" +
        link.title +
      "</td>" +

      "<td contenteditable='true' class='input' id=url-" + link.id + ">" +
        link.url +
      "</td>" +

      "<td class='status' id='read-status-" + link.id + "'>" +
        link.read +
      "</td>" +
    "</tr>"
  );
}

function clearFields() {
  $("#titleField").val("");
  $("#urlField").val("");
}
