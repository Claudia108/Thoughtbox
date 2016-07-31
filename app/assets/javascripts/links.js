$(document).ready(function() {
  searchLinks();
  sortLinks();
});

function searchLinks(){
  $('#filterLinks').on('keyup', function(event){
    event.preventDefault();
    var searchTerm = $(this).val().toLowerCase();

    $(".list-group-item").each(function(_index, link){
      var title = $(this).find('.title').text().toLowerCase();
      var url = $(this).find('.url').text().toLowerCase();

      if (title.match(searchTerm) || url.match(searchTerm)) {
        $(link).show();
      } else {
        $(link).hide();
      }
    });
  });
}

function sortLinks() {
  $('#sortLinks').on('click', function(event) {
    event.preventDefault();
    var sortedLinks = $(".everyLink").sort(function(a, b) {
      var nameA = $(a).find(".title").text().toLowerCase();
      var nameB = $(b).find(".title").text().toLowerCase();
      if (nameA < nameB) {
        return -1;
      } else if (nameA > nameB) {
        return 1;
      } else {
      return 0;
      }
    });
   $(".links").replaceWith(sortedLinks);
  });
}
