galleryScripts = ->
  galleryLength = $(".thumb").length
  galleryCounter = undefined
  $(".thumb").click ->
    $("#enlarged_image").fadeIn()
    $("#enlarged_image").css "background-image": "url(" + $(this).data("largeimg") + ")"
    galleryCounter = $(this).index()
    $(".gallery_counter").html galleryCounter + " / " + $(".thumb").length

  $(".gallery_next").click ->
    if galleryCounter < galleryLength
      galleryCounter += 1
    else
      galleryCounter = 1
    $(".thumb:eq(" + (galleryCounter - 1) + ")").trigger "click"

  $(".gallery_prev").click ->
    if galleryCounter <= galleryLength and galleryCounter > 1
      galleryCounter -= 1
    else
      galleryCounter = galleryLength
    $(".thumb:eq(" + (galleryCounter - 1) + ")").trigger "click"

  $(".gallery_close").click ->
    $("#enlarged_image").fadeOut()

$(window).load ->
  galleryScripts()
