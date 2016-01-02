sendFile = (file, toSummernote) ->
  data = new FormData
  data.append 'upload[image]', file
  $.ajax
    data: data
    type: 'POST'
    url: '/uploads'
    cache: false
    contentType: false
    processData: false
    success: (data) ->
      console.log 'file uploading...'
      toSummernote.summernote "insertImage", data.url


$(document).on 'page:change', (event) ->
  $('[data-provider="summernote"]').each ->
    $(this).summernote
      lang: 'ko-KR'
      height: 500
      codemirror:
        lineWrapping: true
        lineNumbers: true
        tabSize: 2
        theme: 'solarized'
      callbacks:
        onImageUpload: (files) ->
          sendFile files[0], $(this)
  return