gallery = null

getGallery = () -> gallery ?= new Gallery()

$(document).ready(() ->
  getGallery()
)

class Gallery
  constructor: () ->
    @_flickerHttpRequestGallery()
    @_flickerHttpRequestFeaturedWork()

  _flickerHttpRequestGallery: () ->
    flickerAPI = 'https://api.flickr.com/services/rest/?method=flickr.people.getPublicPhotos&api_key=75ef266514506ad0786961e0999b064e&user_id=131046614%40N07&format=json&nojsoncallback=1'

    $.getJSON flickerAPI, (data) ->
      galleryHTML = ''

      $.each(data.photos.photo, (i, photo) ->
        galleryHTML += '<div class="thumb" style="background-image:url(https://farm' + photo.farm + '.staticflickr.com/' + photo.server + '/' + photo.id + '_' + photo.secret + '_m.jpg)" data-img="https://farm' + photo.farm + '.staticflickr.com/' + photo.server + '/' + photo.id + '_' + photo.secret + '"></div>')
      $('#Photos').append(galleryHTML)
      @_bindEventHandler()

  _flickerHttpRequestFeaturedWork: () ->
    flickerAPI = 'https://api.flickr.com/services/rest/?method=flickr.people.getPublicPhotos&api_key=f0fcf8e2c366a04e2caa68f4b482021b&user_id=131046614%40N07&per_page=4&page=1&format=json&nojsoncallback=1'

    $.getJSON flickerAPI, (data) ->
      featuredWorkHTML = ''

      $.each(data.photos.photo, (i, photo) ->
        featuredWorkHTML += '<div class="column oneFourth">'
        featuredWorkHTML += '<a href="gallery.html">'
        featuredWorkHTML += '<img class="thumb" src="https://farm' + photo.farm + '.staticflickr.com/' + photo.server + '/' + photo.id + '_' + photo.secret + '_m.jpg">'
        featuredWorkHTML += '</a>'
        featuredWorkHTML += '</div>'
      )
      $('#FeaturedWork').append(featuredWorkHTML)

  _bindEventHandler: () ->
    galleryLength = $('.thumb').length
    galleryCounter = undefined

    $(".thumb").on('click', (e) ->
      currentTarget = $(e.currentTarget)
      currentTargetDataImg = $(e.currentTarget).data('img')
      $('#EnlargedImage').fadeIn()

      if $(window).width() < 480
        $('#EnlargedImage').css("background-image": "url(" + currentTargetDataImg + '.jpg' + ")")
      else if $(window).width() < 768
        $('#EnlargedImage').css("background-image": "url(" + currentTargetDataImg + '_z.jpg' + ")")
      else if $(window).width() < 1024
        $('#EnlargedImage').css("background-image": "url(" + currentTargetDataImg + '_c.jpg' + ")")
      else
        $('#EnlargedImage').css("background-image": "url(" + currentTargetDataImg + '_b.jpg' + ")")

      galleryCounter = currentTarget.index()
      $(".galleryCounter").html(galleryCounter + " / " + $(".thumb").length)
    )

    $(".galleryNext").on('click', () ->
      if galleryCounter < galleryLength
        galleryCounter += 1
      else
        galleryCounter = 1
      $(".thumb:eq(" + (galleryCounter - 1) + ")").trigger("click")
    )

    $(".galleryPrev").on('click', () ->
      if galleryCounter <= galleryLength and galleryCounter > 1
        galleryCounter -= 1
      else
        galleryCounter = galleryLength
      $(".thumb:eq(" + (galleryCounter - 1) + ")").trigger("click")
    )

    $(".galleryClose").on('click', () ->
      $('#EnlargedImage').fadeOut()
    )
