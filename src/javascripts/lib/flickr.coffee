$(document).ready(() ->
  flickrLoader = new FlickrLoader()
)

class FlickrLoader
  constructor: () ->
    console.log 'constructor'

  flickerAPI = 'https://api.flickr.com/services/rest/?method=flickr.people.getPublicPhotos&api_key=aaaa62bf4a58fb3d6cd45ab19ba43d0e&user_id=131046614%40N07&format=json&nojsoncallback=1&auth_token=72157652204662802-17e052f0a3c1343d&api_sig=4e5528c48d4ed65192fe54fff0b5f350'

  $.getJSON flickerAPI, (data) ->

    photoHTML = '<ul>'

    $.each(data.photos.photo, (i, photo) ->
      console.log photo.owner

      photoHTML += '<li>'
      photoHTML += '<a href="http://www.flickr.com/photos/' + photo.owner + '/' + photo.id + '/" class="image">'
      photoHTML += '<img src="http://www.flickr.com/photos/' + photo.owner + '/' + photo.id + '/"></a></li>'
    )
    photoHTML += '</ul>'
    $('#Photos').html(photoHTML)
