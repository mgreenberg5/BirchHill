navigationController = null

getNavigationController = () -> navigationController ?= new NavigationController()

$(document).ready(() ->
  $("#MoibleMenu").on('click', getNavigationController().animateSideNav)
  $(".bodyOverlay").bind('touchstart click', getNavigationController().animateSideNav)
)

$(window).resize(() ->
  if $(window).width() > 768
    getNavigationController()._menuOpen = true
    getNavigationController().animateSideNav()
)

class NavigationController
  constructor: () ->
    @_animationSpeed = 300
    @_menuOpen = false
    @_body = $("body")
    @_mobileMenu = $("#MoibleMenu")
    @_bodyOverlay = $(".bodyOverlay")

  animateSideNav: () =>
    if @_menuOpen
      bodyXPosition = '0'
      @_body.removeClass('hidden')
      @_mobileMenu.removeClass('active')
      @_bodyOverlay.css("display", "none")
      @_menuOpen = false
    else
      bodyXPosition = '250px'
      @_body.addClass('hidden')
      @_mobileMenu.addClass('active')
      @_bodyOverlay.css("display", "block")
      @_menuOpen = true

    $("body").stop().animate(
      left: bodyXPosition
      @_animationSpeed
    )

    $("#Nav").stop().animate(
      @_animationSpeed
    )
