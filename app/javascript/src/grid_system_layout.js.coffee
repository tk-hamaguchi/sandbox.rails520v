adjustSideMenu = () ->
  content_height = $(window).height() - $('header').height()
  padding_top    = 10
  footer_height  = 46

  main_height =  $('#main_contents').height()

  if main_height? && main_height > (content_height - padding_top - footer_height)
    # $('#main_contents').css('min-height', (content_height - 23) + 'px')
  else
    $('#main_contents').css('min-height', (content_height - padding_top - footer_height) + 'px')

  $('#side_menu').css('min-height', content_height + 'px')


adjustSideMenu()

$(window).on 'resize load page:load', ->
  adjustSideMenu()
