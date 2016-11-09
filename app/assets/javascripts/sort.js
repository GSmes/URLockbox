function sortLinks() {
  $('#sortByTitle').on('click', function(){
    var linkRows = $("#table-body").children('tr');
    var sortedLinks = sortAlphabetically(linkRows, '.titleInput');

    $("#table-body").html(sortedLinks);
    $('#sortByTitle').children().removeClass().addClass('glyphicon glyphicon-sort-by-alphabet');
  });

  $('#sortByUrl').on('click', function(){
    var linkRows = $("#table-body").children('tr');
    var sortedLinks = sortAlphabetically(linkRows, '.urlInput');

    $("#table-body").html(sortedLinks);
    $('#sortByUrl').children().removeClass().addClass('glyphicon glyphicon-sort-by-alphabet');
  });
}

function sortAlphabetically(linkRows, column) {
  return linkRows.sort(function(a, b) {
    var dataA = $(a).children(column).text();
    var dataB = $(b).children(column).text();

    return (dataA < dataB) ? -1 : (dataA > dataB) ? 1 : 0;
  });
}
