galleryScripts = ->
  galleryLength = $(".thumb").length
  galleryCounter = undefined
  $(".thumb").click ->
    console.log $(".thumb")
    $("#EnlargedImage").fadeIn()

    if $(window).width() < 480
      $("#EnlargedImage").css "background-image": "url(" + $(this).data("largeimg") + ("_480x853") + (".jpg") + ")"
    else if $(window).width() < 768
      $("#EnlargedImage").css "background-image": "url(" + $(this).data("largeimg") + ("_768x480") + (".jpg") + ")"
    else if $(window).width() < 1024
      $("#EnlargedImage").css "background-image": "url(" + $(this).data("largeimg") + ("_1024x640") + (".jpg") + ")"
    else
      $("#EnlargedImage").css "background-image": "url(" + $(this).data("largeimg") + ("_1440x900") + (".jpg") + ")"

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
