$(document).ready(function () {
  defineEvents();
  displayLinks();
});

function displayLinks() {
  $.ajax({
    method: "GET",
    url: "/api/v1/links",
    dataType: "JSON",
    success: function(response) {
      printLinks(response);
    }
  });
}

function defineEvents() {
  $("#save-link").on('submit', function(event) {
    event.preventDefault();
    createLink();
  });
}

function printLinks(response) {
  response.forEach(function(link) {
    $('.list-group').append(renderLink(link));
  });
}


function renderLink(link) {
  var title = link.title;
  var url = link.url;
  var status = link.read;
  var id = link.id;

  return '<li class="list-group-item" id="link-' + id + '">' +
        '<h3 class="list-group-item-heading">' +
        '<div class="title" data-title-id="' + id +
        '" contenteditable=true>' + title +
        '</div></h3>' +
        '<h4 class="list-group-item-text">' +
        '<div class="url" data-url-id="' + id +
        '" contenteditable=true>'+ url +
        '</div></h4><br>' +
        '<p class="list-group-item-text">' +
        'This link is <b>' + status + '</b> ' +

        '<a><button type="button" class="btn btn-info"' +
        'data-status-id="' + id + '" data-status="' + status +
        '">Mark as Read</button></a></p>' +
        '</li>';
}

function createLink() {
  var title = $('#LinkTitle').val();
  var url = $('#LinkUrl').val();
  $.ajax({
    method: "POST",
    url: "/api/v1/links",
    dataType: "JSON",
    data: {
      link: {
        title: title,
        url: url
      }
    },
    success: function(link){
      $('.list-group').prepend(renderLink(link));
    }
  });
}
