<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/spoon.css">
<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,700">
<title>FoodGyro</title>
</head>
<body style="margin: 0;padding: 0;">
	<%=request.getContextPath() %>
	<%-- <%response.sendRedirect("https://www.google.com"); %> --%>
	<!-- <img style="filter: blur(1px);position: fixed;" alt="" src="img/comingsoon.jpg"> -->
	<!-- <nav class="navbar navbar-default nav-justified navbar-fixed-top">
		<div class="container">
			<div class="navbar-header page-scroll">
				<button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
			</div>
			<div id="bs-example-navbar-collapse-1" class="collapse navbar-collapse">
				<ul class="nav nav-justified" style="background-color: #006666">
					<li class="hidden active">
						<a href="#page-top"></a>
					</li>
					<li class="active">
						<a class="page-scroll" href="#home">Home</a>
					</li>
					<li class="">
						<a class="page-scroll" href="#about">About</a>
					</li>
					<li class="">
						<a class="page-scroll" href="#menu">Menu</a>
					</li>
					<li class="">
						<a class="page-scroll" href="#services">Services</a>
					</li>
					<li>
						<a class="page-scroll" href="#events">Events</a>
					</li>
					<li>
						<a class="page-scroll" href="#team">Team</a>
					</li>
					<li>
						<a class="page-scroll" href="#contact">Contact us</a>
					</li>
				</ul>
			</div>
		</div>
	</nav> -->
	<header id="home">
		<div class="container">
			<div class="intro-text">
				<div class="fadeInDown wow" style="visibility: visible; animation-name: fadeInDown;">
					<div class="intro-lead-in">
					COMING SOON..<br>Stay tuned for something amazing!!
					</div>
					<div class="intro-heading">
						<form id="emailForm">
							<div class="row">
								<div class="col-lg-3"></div>
								<div class="form-group col-lg-3">
									<input style="height: 47px;" name="email" id="email" class="form-control" type="text" placeholder="Your Email *">
								</div>
								<div class="text-left col-lg-3" style="font-size: 35px;line-height: normal;">
									<button id="submit" class="btn btn-contact" type="button">Get Notified of Launch</button>
								</div>
								<div class="col-lg-3"></div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</header>
	
	<!-- <section id="contact">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 mrgn20-top text-center">
					<div class="fadeInDown wow" style="visibility: visible; animation-name: fadeInDown;">
						<h2 class="section-heading">
							Send us a
							<span class="orange-accent">Message</span>
						</h2>
						<h3 class="section-subheading">For Restaurants</h3>
					</div>
				</div>
			</div>
			<div class="fadeInUp wow" style="visibility: visible; animation-name: fadeInUp;">
				<form id="contactForm" novalidate="" name="sentMessage">
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<input id="name" class="form-control" type="text" required="" placeholder="Your Name *" data-validation-required-message="Please enter your name.">
								<p class="help-block text-danger"> </p>
							</div>
							<div class="form-group">
								<input id="email" class="form-control" type="email" required="" placeholder="Your Email *" data-validation-required-message="Please enter your email address.">
								<p class="help-block text-danger"> </p>
							</div>
							<div class="form-group">
								<input id="phone" class="form-control" type="tel" required="" placeholder="Your Phone *" data-validation-required-message="Please enter your phone number.">
								<p class="help-block text-danger"> </p>
							</div>
							<div class="form-group">
								<select class="form-control">
									<option> How we can help you? </option>
									<option> I would like a sample menu meeting </option>
									<option> Please, organize my event </option>
									<option> Reserve a table </option>
								</select>
								<p class="help-block text-danger"> </p>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<textarea id="message" class="form-control" required="" placeholder="Tell us a little bit of your event or evening with us *" name="message" data-validation-required-message="Please enter a message."></textarea>
								<p class="help-block text-danger"> </p>
							</div>
						</div>
						<div class="clearfix"> </div>
						<div class="col-lg-12 text-left">
							<div id="success"> </div>
							<button class="btn btn-contact" type="submit">Send Message</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</section> -->
	
	<script type="text/javascript">
	$('a.page-scroll').bind('click', function(event) {
        var $anchor = $(this);
        $('html, body').stop().animate({
            scrollTop: $($anchor.attr('href')).offset().top
        }, 1500, 'easeInOutExpo');
        event.preventDefault();
    });
	
	$("#submit").click(function() {
		$("#emailForm").validate({
			rules: {
	            email: {
	                required: true,
	                email: true
	            }
			},
			messages: {
				email: 'Please enter valid email'
			},
			submitHandler: function (form) {
				$.ajax({
					url: "save_email.yfy",
					data: 'email='+$("#email").val(),
					type: "post",
					success: function(status){
						if(status == 'success'){
						 	alert("Email saved successfully!!");
						} else {
							alert("Error occured");
						}
					}
				});
			}
		});
		$("#emailForm").submit();
	});
	</script>
</body>
</html>