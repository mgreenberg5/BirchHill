animationSpeed = 300
menuOpen = false
desktopWindowWidth = 768

$(window).resize(() ->
  if $(window).width() > desktopWindowWidth
    menuOpen = true
    animateSideNav()
)

$(document).on('click', "#MobileMenu", () -> animateSideNav())
$(document).on('click', ".bodyOverlay", () -> animateSideNav())

animateSideNav = (() ->
  if menuOpen
    bodyXPosition = '0'
    $("html").removeClass('hidden')
    $("body").removeClass('hidden')
    $(".bodyOverlay").css("display", "none")
    menuOpen = false
  else
    bodyXPosition = '250px'
    $("html").addClass('hidden')
    $("body").addClass('hidden')
    $(".bodyOverlay").css("display", "block")
    menuOpen = true

  $("body").stop().animate(
    left: bodyXPosition
    animationSpeed
  )

  $("#Nav").stop().animate(
    left: menuXPosition
    animationSpeed
  )
)
