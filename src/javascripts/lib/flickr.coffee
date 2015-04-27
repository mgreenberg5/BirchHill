$(document).ready(() ->
  flickrLoader = new FlickrLoader()
)

class FlickrLoader

  flickerAPI = 'https://api.flickr.com/services/rest/?method=flickr.people.getPublicPhotos&api_key=aaaa62bf4a58fb3d6cd45ab19ba43d0e&user_id=131046614%40N07&format=json&nojsoncallback=1&auth_token=72157652204662802-17e052f0a3c1343d&api_sig=4e5528c48d4ed65192fe54fff0b5f350'

  $.getJSON flickerAPI, (data) ->
    photoHTML = ""

    $.each(data.photos.photo, (i, photo) ->
      photoHTML +=
        '<div data-largeimg="https://farm' + photo.farm + '.staticflickr.com/' + photo.server + '/' + photo.id + '_' + photo.secret + '_o" class="thumb">
          <img src="https://farm' + photo.farm + '.staticflickr.com/' + photo.server + '/' + photo.id + '_' + photo.secret + '_m.jpg">
        </div>'
    )
    $('#Photos').append(photoHTML)
