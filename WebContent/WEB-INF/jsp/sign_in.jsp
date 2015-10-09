<%@ include file="includes/include_taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
 <script type="text/javascript" src="js/bootstrap.min.js"></script>
 <script type="text/javascript">
	window.alert = function(){};
	var defaultCSS = document.getElementById('bootstrap-css');
	function changeCSS(css){
	    if(css) $('head > link').filter(':first').replaceWith('<link rel="stylesheet" href="'+ css +'" type="text/css" />'); 
	    else $('head > link').filter(':first').replaceWith(defaultCSS); 
	}
	$( document ).ready(function() {
	  var iframe_height = parseInt($('html').height()); 
	  window.parent.postMessage( iframe_height, 'http://designsave.com');
	});
	
	 window.fbAsyncInit = function() {
	    FB.init({
	      appId      : '1634092413542116',
	      xfbml      : true,
	      cookie	 : true,	
	      version    : 'v2.4'
	    });
	  };

	(function(d, s, id){
	   var js, fjs = d.getElementsByTagName(s)[0];
	   if (d.getElementById(id)) {return;}
	   js = d.createElement(s); js.id = id;
	   js.src = "//connect.facebook.net/en_US/sdk.js";
	   fjs.parentNode.insertBefore(js, fjs);
	 }(document, 'script', 'facebook-jssdk'));
	
	// This is called with the results from from FB.getLoginStatus().
	  function statusChangeCallback(response) {
	    // The response object is returned with a status field that lets the
	    // app know the current login status of the person.
	    // Full docs on the response object can be found in the documentation
	    // for FB.getLoginStatus().
	    if (response.status === 'connected') {
	      // Logged into your app and Facebook.
	      fbLoginAPI();
	    } else if (response.status === 'not_authorized') {
	      // The person is logged into Facebook, but not your app.
	      document.getElementById('fbStatus').innerHTML = 'Please log ' +
	        'into this app.';
	    } else {
	      // The person is not logged into Facebook, so we're not sure if
	      // they are logged into this app or not.
	      document.getElementById('fbStatus').innerHTML = 'Please log ' +
	        'into Facebook.';
	    }
	  }

	  // This function is called when someone finishes with the Login
	  // Button.  See the onlogin handler attached to it in the sample
	  // code below.
	  function checkLoginState() {
	    FB.getLoginStatus(function(response) {
	      statusChangeCallback(response);
	    });
	  }

	  // Now that we've initialized the JavaScript SDK, we call 
	  // FB.getLoginStatus().  This function gets the state of the
	  // person visiting this page and can return one of three states to
	  // the callback you provide.  They can be:
	  //
	  // 1. Logged into your app ('connected')
	  // 2. Logged into Facebook, but not your app ('not_authorized')
	  // 3. Not logged into Facebook and can't tell if they are logged into
	  //    your app or not.
	  //
	  // These three cases are handled in the callback function.

	  // Here we run a very simple test of the Graph API after login is
	  // successful.  See statusChangeCallback() for when this call is made.
	  function fbLoginAPI() {
	    FB.api('/me', function(response) {
	      console.log(JSON.stringify(response));
	      document.getElementById('fbStatus').innerHTML =
	        'Thanks for logging in, ' + response.name + '!';
	      $("#fbStatus").addClass('alert alert-success animated fadeInUp');
	      
	      
	    });
	  }
</script> 
<title>SignIn</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<div class="login-container" id="loginForm">
			<div id="fbStatus" class=""></div>
			<c:if test="${param.error eq 'true'}">
				<div id="output" class="alert alert-danger animated fadeInUp">Wrong Credentials!!</div>
			</c:if>
			<c:if test="${status eq 'success'}">
				<div id="output" class="alert alert-success animated fadeInUp">Verification email has been sent to you</div>
			</c:if>
			<c:if test="${status eq 'fail'}">
				<div id="output" class="alert alert-danger animated fadeInUp">Error!! Please try again</div>
			</c:if>
			<div class="avatar"></div>
			<div class="form-box">
				<form method="post" action="j_spring_security_check">
					<input id="username" type="text" placeholder="username" name="j_username">
					<input type="password" placeholder="password" id="password" name="j_password">
					<button class="btn btn-info btn-block login" type="submit">Login</button>
					<a href="#">Forgotten your password?</a>
					<fb:login-button scope="public_profile,email" onlogin="checkLoginState();">
					</fb:login-button>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					<button type="button" class="btn btn-success btn-block signup" onclick="showSignUpForm()" id="sButton">Sign Up</button>
				</form>
			</div>
		</div>
		<div class="login-container" id="signUpForm" style="display: none;">
			<div id="output"></div>
			<div class="avatar"></div>
			<div class="form-box">
				<form method="post" action="register.yfy">
					<input type="email" placeholder="email*" name="emailId" required="required">
					<input type="number" placeholder="mobile number*" name="mobileNo" required="required">
					<input type="password" placeholder="password*" id="password" required="required" name=password>
					<input type="password" placeholder="confirm password*" id="confirmPassword" required="required" name="confirmPassword">
					<button class="btn btn-info btn-block login" type="submit">SignUp</button>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					<button type="button" class="btn btn-success btn-block signup" onclick="showLoginForm()" id="lButton" style="display: none;">Login</button>
				</form>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
$(function(){
	var textfield = $("input[name=user]");
	/* $('#loginForm button[type="submit"]').click(function(e) {
	    e.preventDefault();
	    //little validation just to check username
	    if (textfield.val() != "" && $("#password").val() != "") {
	        //$("body").scrollTo("#output");
	        $("#output").addClass("alert alert-success animated fadeInUp").html("Welcome back " + "<span style='text-transform:uppercase'>" + textfield.val() + "</span>");
	        $("#output").removeClass(' alert-danger');
	        $("input").css({
	        "height":"0",
	        "padding":"0",
	        "margin":"0",
	        "opacity":"0"
	        });
	        //change button text 
	        $('button[type="submit"]').html("continue")
	        .removeClass("btn-info")
	        .addClass("btn-default").click(function(){
	        $("input").css({
	        "height":"auto",
	        "padding":"10px",
	        "opacity":"1"
	        }).val("");
	        });
	        
	        //show avatar
	        $(".avatar").css({
	        	"background-image": "url('http://api.randomuser.me/0.3.2/portraits/women/35.jpg')",
	            "border": "2px solid #aaa",
	            "border-radius": "100%"
	        });
	    } else {
	        //remove success mesage replaced with error message
	        $("#output").removeClass(' alert alert-success');
	        $("#output").addClass("alert alert-danger animated fadeInUp").html("sorry enter a username and password ");
	    }
	    //console.log(textfield.val());
	
	}); */
	
	$("#output").fadeOut(4000,"linear");
});
function showSignUpForm() {
	$("#loginForm").hide();
	$("#signUpForm").show();
	$("#sButton").hide();
	$("#lButton").show();
}
function showLoginForm() {
	$("#loginForm").show();
	$("#signUpForm").hide();
	$("#sButton").show();
	$("#lButton").hide();
}
</script>
</html>