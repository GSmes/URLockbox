function searchLinks() {
  $('#searchField').on('keyup', function(e){
    var query = this.value.toLowerCase();
    var linkRows = $("#table-body").children('tr');

    linkRows.each(function (index, link) {
      var linkRow = $(link);

      if (linkRow.children('.search').text().toLowerCase().includes(query)) {
        linkRow.show();
      } else {
        linkRow.hide();
      }
    });
  });
}
