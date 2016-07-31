$(document).ready(function() {
  searchLinks();
  sortLinks();
  markLinks();
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

function markLinks() {
  $('#markLinks').on('click', function(event) {
    event.preventDefault();
    var id = $(this).parents(".everyLink").data("id");
    var readStatus = $(this).parents(".everyLink").data("read");
    var link = $(this).parents(".everyLink");
    if (readStatus === false) {
      readStatus = true;
    } else {
      readStatus = false;
    }
    updateDatabase(id, readStatus, link);
  });
}

// function changeReadStatus(id) {
//   var read_status = $(".everyLink").data("id");
//       var readStatus = $(this).text();
//       if (readStatus === "Mark as Read"){
//         readStatus = $(this).text("Mark as Unread");
//       } else {
//         readStatus = $(this).text("Mark as Read");
//       }
//       return readStatus;
//     }
// };

function updateDatabase (id, status, link) {
  $.ajax({
    url: "api/v1/links/" + id,
    method: "put",
    dataType: "json",
    data: { link:
            {read: status}
          },
    success: function() {
      changeReadStatus(status, link);
    }
  });
}

function changeReadStatus(status, link) {
  if (status === false) {
    $(link).removeClass("read");
    $(link).addClass("unread");
    $(link).find("button").text("Mark as Read");
  } else {
    $(link).removeClass("unread");
    $(link).addClass("read");
    $(link).find("button").text("Mark as Unread");
  }
}
//  <a href="#" class="markAsRead <%= "hidden" if link.read %>">(Mark as read)</a>
// <a href="#" class="markAsUnread <%= "hidden" if !link.read %>">(Mark as unread)</a>
