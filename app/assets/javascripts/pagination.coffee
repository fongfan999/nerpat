$(document).on 'turbolinks:load', ->
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination a.next').attr('href')
      scrollBottom = $(document).height() - $(window).height() - $(window).scrollTop()

      if url && scrollBottom < 200 && $.active == 0
        $('.pagination-spinner').show()
        $('.pagination').hide()
        $.getScript url, ->
          $('.pagination-spinner').first().remove()

