$(document).ready(function() {
  searchLinks();
  sortLinks();
  markAsRead();
  markAsUnread();
  filterUnreadLinks();

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

function markAsRead() {
  $('.markAsRead').on('click', function(event) {
    event.preventDefault();
    var id = $(this).parents(".everyLink").data("id");
    updateDatabase(id, this, true);
  });
}

function markAsUnread() {
  $('.markAsUnread').on('click', function(event) {
    event.preventDefault();
    var id = $(this).parents(".everyLink").data("id");
    updateDatabase(id, this, false);
  });
}

function updateDatabase (id, button, status) {
  $.ajax({
    url: "api/v1/links/" + id,
    method: "put",
    dataType: "json",
    data: { link:
            {read: status}
          },
    success: function() {
      changeReadStatus(button);
    }
  });
}

function changeReadStatus(button) {
  $(button).toggleClass('hidden');
  $(button).siblings().first().toggleClass('hidden');
  $(button).parent().parent().toggleClass('read');
}

function filterUnreadLinks() {
  $('#unreadLinks').on('click', function (event) {
    event.preventDefault();
    $('.everyLink').each(function(i, link) {
      if ($(link).hasClass('read')) {
        $(link).hide();
      } else {
        $(link).show();
      }
    });
  });
}
