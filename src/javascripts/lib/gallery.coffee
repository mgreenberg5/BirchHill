$(document).ready(() ->
  gallery = new Gallery()
)

class Gallery

  flickerAPI = 'https://api.flickr.com/services/rest/?method=flickr.people.getPublicPhotos&api_key=aaaa62bf4a58fb3d6cd45ab19ba43d0e&user_id=131046614%40N07&format=json&nojsoncallback=1&auth_token=72157652204662802-17e052f0a3c1343d&api_sig=4e5528c48d4ed65192fe54fff0b5f350'

  $.getJSON flickerAPI, (data) ->
    photoHTML = ""

    $.each(data.photos.photo, (i, photo) ->
      photoHTML +=
        '<div data-largeimg="https://farm' + photo.farm + '.staticflickr.com/' + photo.server + '/' + photo.id + '_' + photo.secret + '" class="thumb">
          <img src="https://farm' + photo.farm + '.staticflickr.com/' + photo.server + '/' + photo.id + '_' + photo.secret + '_m.jpg">
        </div>'
    )
    $('#Photos').append(photoHTML)
    _galleryScripts()


  _galleryScripts = ->
    galleryLength = $(".thumb").length
    galleryCounter = undefined
    $(".thumb").click ->
      $("#EnlargedImage").fadeIn()

      if $(window).width() < 480
        $("#EnlargedImage").css "background-image": "url(" + $(this).data('largeimg') + '.jpg' + ")"
      else if $(window).width() < 768
        $("#EnlargedImage").css "background-image": "url(" + $(this).data('largeimg') + '_z.jpg' + ")"
      else if $(window).width() < 1024
        $("#EnlargedImage").css "background-image": "url(" + $(this).data('largeimg') + '_c.jpg' + ")"
      else
        $("#EnlargedImage").css "background-image": "url(" + $(this).data('largeimg') + '_b.jpg' + ")"

      galleryCounter = $(this).index()
      $(".galleryCounter").html galleryCounter + " / " + $(".thumb").length

    $(".galleryNext").on('click', () ->
      if galleryCounter < galleryLength
        galleryCounter += 1
      else
        galleryCounter = 1
      $(".thumb:eq(" + (galleryCounter - 1) + ")").trigger "click"
    )

    $(".galleryPrev").on('click', () ->
      if galleryCounter <= galleryLength and galleryCounter > 1
        galleryCounter -= 1
      else
        galleryCounter = galleryLength
      $(".thumb:eq(" + (galleryCounter - 1) + ")").trigger "click"
    )

    $(".galleryClose").on('click', () ->
      $("#EnlargedImage").fadeOut()
    )

