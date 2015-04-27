galleryScripts = ->
  galleryLength = $(".thumb").length
  galleryCounter = undefined
  $(".thumb").click ->
    $("#EnlargedImage").fadeIn()

    if $(window).width() < 480
      $("#EnlargedImage").css "background-image": "url(" + $(this).data("largeimg") + (".jpg") + ")"
    else if $(window).width() < 768
      $("#EnlargedImage").css "background-image": "url(" + $(this).data("largeimg") + (".jpg") + ")"
    else if $(window).width() < 1024
      $("#EnlargedImage").css "background-image": "url(" + $(this).data("largeimg") + (".jpg") + ")"
    else
      $("#EnlargedImage").css "background-image": "url(" + $(this).data("largeimg") + (".jpg") + ")"

    galleryCounter = $(this).index()
    $(".galleryCounter").html galleryCounter + " / " + $(".thumb").length

  $(".galleryNext").click ->
    if galleryCounter < galleryLength
      galleryCounter += 1
    else
      galleryCounter = 1
    $(".thumb:eq(" + (galleryCounter - 1) + ")").trigger "click"

  $(".galleryPrev").click ->
    if galleryCounter <= galleryLength and galleryCounter > 1
      galleryCounter -= 1
    else
      galleryCounter = galleryLength
    $(".thumb:eq(" + (galleryCounter - 1) + ")").trigger "click"

  $(".galleryClose").click ->
    $("#EnlargedImage").fadeOut()

$(window).load ->
  galleryScripts()
