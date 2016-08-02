$(document).ready(function() {
  $('#filterLinks').on('keyup', function(event){
    event.preventDefault();
    var searchTerm = $(this).val().toLowerCase();
    searchLinks(searchTerm);
  });

  $('#sortLinks').on('click', function(event) {
    event.preventDefault();
    sortLinks();
  });

  $('.markAsRead').on('click', function(event) {
    event.preventDefault();
    var id = $(this).parents(".everyLink").data("id");
    sendUpdate(id, this, true);
  });

  $('.markAsUnread').on('click', function(event) {
    event.preventDefault();
    var id = $(this).parents(".everyLink").data("id");
    sendUpdate(id, this, false);
  });

  $('#unreadLinks').on('click', function (event) {
    event.preventDefault();
    filterLinksByReadStatus(false);
  });

  $('#readLinks').on('click', function (event) {
    event.preventDefault();
    filterLinksByReadStatus(true);
  });

  $('#allLinks').on('click', function (event) {
    event.preventDefault();
    allLinks();
  });
});

function searchLinks(searchTerm) {
  $(".list-group-item").each(function(_index, link){
    var title = $(this).find('.title').text().toLowerCase();
    var url = $(this).find('.url').text().toLowerCase();
    if (title.match(searchTerm) || url.match(searchTerm)) {
      $(link).show();
    } else {
      $(link).hide();
    }
  });
}

function sortLinks() {
  var sortedLinks = $('.everyLink').sort(function(a, b) {
    var linkA = $(a).find(".title").text().toLowerCase();
    var linkB = $(b).find(".title").text().toLowerCase();
    if (linkA < linkB) {
      return -1;
    } else if (linkA > linkB) {
      return 1;
    } else {
      return 0;
    }
  });
  $(".links").replaceWith(sortedLinks);
}

function sendUpdate (id, button, status) {
  $.ajax({
    url: "api/v1/links/" + id,
    method: "PATCH",
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

function filterLinksByReadStatus(readStatus) {
  $('.everyLink').each(function(i, link) {
    if(readStatus) {
      $(link).hasClass('read') ? $(link).show() : $(link).hide();
    } else {
      $(link).hasClass('read') ? $(link).hide() : $(link).show();
    }
  });
}

function allLinks() {
  $('.everyLink').show();
}
