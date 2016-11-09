function sortLinks() {
  $('#sortByTitle').on('click', function(){
    var linkRows = $("#table-body").children('tr');
    var sortedLinks = sortAlphabetically(linkRows, '.titleInput');

    $("#table-body").html(sortedLinks);

    toggleBtnClass('#sortByTitle', '#sortByUrl');
  });

  $('#sortByUrl').on('click', function(){
    var linkRows = $("#table-body").children('tr');
    var sortedLinks = sortAlphabetically(linkRows, '.urlInput');

    $("#table-body").html(sortedLinks);

    toggleBtnClass('#sortByUrl', '#sortByTitle');
  });
}

function sortAlphabetically(linkRows, column) {
  return linkRows.sort(function(a, b) {
    var dataA = $(a).children(column).text();
    var dataB = $(b).children(column).text();

    return (dataA < dataB) ? -1 : (dataA > dataB) ? 1 : 0;
  });
}

function toggleBtnClass(sortedColumn, unsortedColumn) {
  $(sortedColumn).children().removeClass().addClass('glyphicon glyphicon-sort-by-alphabet');
  $(unsortedColumn).children().removeClass().addClass('glyphicon glyphicon-sort');
}
