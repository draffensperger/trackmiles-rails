$ ->
  $("#send-android-link").click ->
    $.ajax(
      type: "POST"
      url: "/email_android_link"
      data:
        email: $("#android-link-email").val()
    ).done ->
      $("#email-sent-msg").html $("#email-sent-msg-template").html()
