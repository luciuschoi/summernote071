# Summernote 0.7.1.0 Demo for Rails


최근에 `summernote`가 `0.7.1` 버전으로 업그레이드되면서 `summernote-rails` 젬도 `0.7.1.0` 버전으로 업데이트되었다.

예전에 [`Bootstrap용 WYSIWYG 웹에디터 Summernote 사용시 서버로 로컬 이미지 업로드후 삽입하기 (1)`](http://bit.ly/summernote-rails-for-fileupload-1)라는 제목의 글을 블로그에 올린 바 있다.

`summernote-rails` 젬이 `0.7.1.0`으로 버전업되면서 기능추가 및 업데이트가 있어서 이 글에서는 이전 글에서 업데이트된 내용을 소개한다.

### 1. 프로젝트 작성 환경

- 루비 2.3.0
- 레일스 4.2.5

### 2. 샘플 프로젝트의 생성

```
$ rails new blog
```

### 3. Gemfile에 추가할 젬

```
gem 'bootstrap-sass'
gem 'font-awesome-rails'
gem 'simple_form'
gem 'summernote-rails', '0.7.1.0'
gem 'codemirror-rails'
gem 'paperclip'
```

### 4. 셋팅

`simple_form` 설치

```
$ rails g simple_form:install --bootstrap
```

`app/assets/javascripts/application.js`

```
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require codemirror
//= require codemirror/modes/ruby
//= require summernote
//= require summernote/locales/ko-KR
//= require turbolinks
//= require_tree .
```

`app/assets/stylesheets/application.scss`

```
@import "bootstrap";
@import "font-awesome";
@import "codemirror";
@import "summernote";
@import "codemirror/themes/solarized";
```


`app/assets/javascripts/summernote_upload.coffee`

```
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
```

> **주의** : 15번 코드라인은 폼이 터보링크로 연결되어 브라우저에 나타날 때 `document`의 `page:change` 이벤트에서 `summernote` 에디터가 제대로 동작하도록 변경한 것이다.


`app/views/posts/_form.html.erb`

```
<%= simple_form_for(@post) do |f| %>
  <%= f.error_notification %>

  <div class="form-inputs">
    <%= f.input :title %>
    <%= f.input :content, as: :summernote %>
  </div>

  <div class="form-actions">
    <%= f.button :submit %>
  </div>
<% end %>
```
