$(function() {
	$(".click").focus(function() {
		$(".right_5 :text").css("display","inline");
	});
	$(".click").blur(function() {
		$(".right_5 :text").css("display","none");
	});
});
$(document).ready(function(){
  $("#reason_1").click(function(){
  $("#solve_1").load("../web/reason/reason1.txt");
  $("#solve_2").fadeOut(300);
  setTimeout("$('#solve_1').fadeIn(300)",300);
  });
  $("#reason_2").click(function(){
  $("#solve_1").load("../web/reason/reason2.txt");
  $("#solve_2").fadeOut(300);
  setTimeout("$('#solve_1').fadeIn(300)",300);
  });
  $("#reason_3").click(function(){
  $("#solve_1").load("../web/reason/reason3.txt");
  $("#solve_2").fadeOut(300);
  setTimeout("$('#solve_1').fadeIn(300)",300);
  });
  $("#reason_4").click(function(){
  $("#solve_1").load("../web/reason/reason4.txt");
  $("#solve_2").fadeOut(300);
  setTimeout("$('#solve_1').fadeIn(300)",300);
  });
  $("#reason_5").click(function(){
  $("#solve_1").load("../web/reason/reason5.txt");
  $("#solve_2").fadeOut(300);
  setTimeout("$('#solve_1').fadeIn(300)",300);
  });
  $("#reason_6").click(function(){
  $("#solve_1").load("../web/reason/reason6.txt");
  $("#solve_2").fadeOut(300);
  setTimeout("$('#solve_1').fadeIn(300)",300);
  });
  $("#reason_7").click(function(){
  $("#solve_1").load("../web/reason/reason7.txt");
  $("#solve_2").fadeOut(300);
  setTimeout("$('#solve_1').fadeIn(300)",300);
  });
  $("#reason_8").click(function(){
  $("#solve_1").load("../web/reason/reason8.txt");
  $("#solve_2").fadeOut(300);
  setTimeout("$('#solve_1').fadeIn(300)",300);
  });
  $("#reason_9").click(function(){
  $("#solve_1").load("../web/reason/reason9.txt");
  $("#solve_2").fadeOut(300);
  setTimeout("$('#solve_1').fadeIn(300)",300);
  });
});