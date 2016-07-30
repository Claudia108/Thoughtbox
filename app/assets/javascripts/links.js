$(document).ready(function() {
  searchLinks();
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
