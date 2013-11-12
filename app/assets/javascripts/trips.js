// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(function(){
  var urlsToVisit = [];
  var urlIndex;
  
  $('#reimb-frame').load(function() {
    setTimeout(reimbFrameLoaded, 50);
  });
  
  $('#load-reimb').click(function() {
    var displayMileageLog = 'https://staffweb.cru.org/ss/servlet/ReimbServlet?Action=DisplayMileLog&erncd=MIL';
    urlsToVisit = [displayMileageLog];
    urlIndex = 0;                    
    for (num in gon.trips) {            
      urlsToVisit.push(getURLForTrip(gon.trips[num]));      
    }    
    reimbFrameLoaded();        
  });  
  
  var formatDate = function(jsonDate) {
    var dateParts = jsonDate.split(/[T-]/);
    return dateParts[1] + '/' + dateParts[2] + '/' + dateParts[0];
  }
  
  var getURLForTrip = function(trip) {
    var enc = encodeURIComponent; 
    return 'https://staffweb.ccci.org/ss/servlet/ReimbServlet' +
      '?Action=AddMileLogLine' +
      '&Submit=Add%20Miles%20to%20Log' +
      '&mileageRate=ministry' +
      '&Miles=' + enc(Math.round(trip.miles)) +
      '&Destination=' + 
        enc(trip.start_place_summary + '->' + trip.end_place_summary) +
      '&Purpose=' + enc(trip.purpose) +
      '&LogDate=' + enc(formatDate(trip.start_time))   
  }
  
  var reimbFrameLoaded = function() {
    if (urlIndex < urlsToVisit.length) {
      //$('#reimb-frame').attr('src', urlsToVisit[urlIndex]);
      var reimbFrame = document.getElementById("reimb-frame");
      reimbFrame.src = urlsToVisit[urlIndex];    
      //writeInfo("Loading line: " + (urlIndex + 1) + "/" + urlsToVisit.length);
      //writeInfo("URL: " + urlsToVisit[urlIndex])
      
      $('#reimb-container').css('height', 1100 + 70 * urlIndex + "px");
    }
    urlIndex++;
  };    
})
