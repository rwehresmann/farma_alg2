// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require turbolinks
//= require bootstrap-sprockets
//= require jquery_ujs
//= require AdminLTE/bootstrap
//= require AdminLTE/AdminLTE/app
//= require jquery-ui-1.9.2.custom.min
//= require jquery_ujs
//= require jquery.md5
//= require tether
//= require bootbox4.min
//= require codemirror/lib/codemirror
//= require codemirror/mode/pascal/pascal
//= require codemirror/mode/ruby/ruby
//= require codemirror/mode/clike/clike
//= require prettify
//= require run_prettify
//= require_tree ./super_simple_slider
//= require_tree .

/* Dashboard */

var answerShowCallback = null;
var searchResultCallback = null;

var comecei = 0;
$(document).ajaxSend(function(){
  comecei +=1;
  if(comecei == 1)
  {
    $("body").addClass("pace-running");
    $("body").removeClass("pace-done");
    $(".pace").removeClass("pace-inactive");
    $(".pace").addClass("pace-active");
  }
});

$(document).ajaxComplete(function(){
  comecei -=1;
  if(!comecei)
  {
    $("body").removeClass("pace-running");
    $("body").addClass("pace-done");
    $(".pace").addClass("pace-inactive");
    $(".pace").removeClass("pace-active");
  }
});

$(document).ready(function(){
  $('.shorted-box').each(function(){
    if($(this).height() > 200){
      $(this).addClass("shorted-box-body");
      $(this).parent().append("<a href='#' class='show-box'><div class='box-footer shorted-box-footer text-center'><b>Mostrar mais ...</b></div></a>");
    }
  });

  $(".content").on('click',".show-box", function(ev){
    ev.preventDefault();
    var box = $(this).parent();

    $(box).find(".shorted-box-body").removeClass("shorted-box-body");
    $(box).find(".box-footer").remove();
  });

});
