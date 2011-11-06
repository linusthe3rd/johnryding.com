$(document).ready(function() {
  $("#project-listing").bind("click", function(e){
    node = getEventTarget(e);
    slideId = getSlideId(node);
    
    $("#project-listing").addClass("previous");
    $("#"+slideId).removeClass("next");
  });
  
  $("#slides").bind("click", function(e){
    node = getEventTarget(e);
    slideId = getSlideId(node);
    
    if ( $(node).hasClass("back-button") ){
      $("#project-listing").removeClass("previous");
      $("#"+slideId).addClass("next");
    }
  });
});

function getSlideId(node){
  while ( $(node).attr("slideId") == undefined ){
    node = node.parentNode;
  }
  
  return $(node).attr("slideId")
}

function getEventTarget(e){
  var targ;
  
  if (!e) {
    var e = window.event;
  }
  
  if (e.target) {
    targ = e.target;
  } else if (e.srcElement) {
    targ = e.srcElement;
  }
  
  if (targ.nodeType == 3){
    // defeat Safari bug
  	targ = targ.parentNode;
  }
  
  return targ
}