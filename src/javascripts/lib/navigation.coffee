animationSpeed = 300
menuOpen = false
desktopWindowWidth = 1025

$(document).ready(() ->
  $(".navMainTop a[href^=\"../" + getSectionPathComponent() + "\"]").addClass("active")
  $(".navSecondary .section ul li a[href^=\"" + getPagePathComponent() + "\"]").addClass("active")
)

$(window).resize(() ->
  if $(window).width() > desktopWindowWidth
    menuOpen = true
    animateSideNav()
)

$(document).on('click', ".mobileMenu", () -> animateSideNav())

animateSideNav = (() ->
  if menuOpen
    menuXPosition = '-250px'
    bodyXPosition = '0'
    $("body").removeClass('hidden')
    $(".navMain").removeClass('shadow')
    menuOpen = false
  else
    menuXPosition = '0px'
    bodyXPosition = '250px'
    $("body").addClass('hidden')
    $(".navMain").addClass('shadow')
    menuOpen = true

  $("body").stop().animate(
    left: bodyXPosition
    animationSpeed
  )

  $(".navMain").stop().animate(
    left: menuXPosition
    animationSpeed
  )
)

getSectionPathComponent = () -> location.pathname.split("/").reverse()[1]

getPagePathComponent = () -> location.pathname.split("/").reverse()[0]
