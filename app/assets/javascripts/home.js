$(function(){  
  $('#send-android-link').click(function() {
  	var email = $('').val('#android-link-email');
  	$.ajax({
  		type: 'POST',
  		url: '/email_android_link',
  		email: email
  	}).done(function() {
		$('#email-sent-msg').html($('#email-sent-msg-template').html());  		
  	});
  });
});
