function filterLinks() {
  $('#showRead').on('click', function(e){
    e.preventDefault();
    filterList('true');
  });

  $('#showUnread').on('click', function(e){
    e.preventDefault();
    filterList('false');
  });

  $('#showAll').on('click', function(e){
    e.preventDefault();
    fullList();
  });
}

function filterList(readStatus) {
  var linkRows = $("#table-body").children('tr');

  linkRows.each(function(index, link) {
    var linkRow = $(link);

    if (linkRow.children('.status').text().includes(readStatus)) {
      linkRow.show();
    } else {
      linkRow.hide();
    }
  });
}

function fullList() {
  var linkRows = $("#table-body").children('tr');

  linkRows.each(function(index, link) {
    $(link).show();
  });
}
