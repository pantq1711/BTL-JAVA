<%@page import="java.sql.Connection"%>
<%@page import="java.text.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<div class="container-fluid" style="height: 10px;"></div>

<style>
.tooltip-1 {
	position: relative;
	display: inline-block;
	z-index: 10;
	heigth: fit-content;
	width: 100px;
	text-align: center;
	margin-top: 10px;
}

.tooltip-1 .tooltiptext-1 {
	padding: 10px;
	visibility: hidden;
	width: 200px;
	background-color: white;
	color: black;
	text-align: left;
	border-radius: 6px;
	position: absolute;
	margin-top: 2px;
	z-index: 10;
	top: 110%;
	left: 50%;
	margin-left: -60px;
	box-shadow: rgba(0, 0, 0, 0.16) 0px 1px 4px;
}

.tooltip-1 .tooltiptext-1::after {
	content: "";
	position: absolute;
	bottom: 100%;
	left: 30%;
	margin-left: -5px;
	border-width: 5px;
	border-style: solid;
	border-color: transparent transparent #ccc transparent;
}

.tooltiptext-1 .item-user {
	height: fit-content;
	padding: 10px;
	border-bottom: 1px solid #ccc;
}

.tooltiptext-1 div a {
	color: rgba(0, 0, 0, 0.7);
	text-decoration: none;
	transition: all 0.1s linear;
}

.tooltip-1 .usrn i{
	transition:all 0.2s linear;
}


.tooltiptext-1 .item-user:hover a {
	color: #ccc;
}

.tooltip-1 .usrn:hover i{
	opacity:0.4;
	font-size:18px;
}

.tool-main {
	position: relative !important;
}

.nav-cart {
	position: absolute !important;
	font-size: 25px !important;
	right:-20px!important; 
	top:-7px!important;
	background-color: rgba(0, 0, 0, 0);
	color: rgba(0, 0, 0, 0.9) !important;
	transition: all 0.3s linear;
	z-index: 20;
}

.nav-cart:hover, .nav-cart:hover i {
	background-color: white !important;
	transform: scale(1.1);
}

.search-form {
	border-radius: 20px;
	width: 400px !important;
	position: relative !important;
	height: 50px !important;
}

.search-form.form-inline {
	position: relative !important;
}

.icon-search {
	position: absolute !important;
	right: 10px;
	background-color: rgba(0, 0, 0, 0) !important;
	color: rgba(0, 0, 0, 0.9) !important;
}
</style>
<div class="nav-logon container-fluid p-3 bg-light">
	<div class="nav-group row">
		<div class="logo col-md-3 text-success">
			<h3 style="color: black;">
				<img src="img/backg1.png" alt="" style="height: 50px; width: 200px;">
			</h3>
		</div>
		<div class="block-buy col-md-7">
			<form class="search-form form-inline my-2  my-lg-0"
				action="search.jsp" method="post">
				<input class="search-form form-control mr-sm-2" type="search"
					placeholder="Search" aria-label="Search" name="ch">
				<button class="icon-search btn btn-primary my-2 my-sm-0"
					type="submit">
					<i class="fa-solid fa-magnifying-glass"></i>
				</button>

			</form>
		</div>

		<div class="log">
			<div class="tooltip-1">
				<div class="user-main">
					<div class="tool-main">
						<div class="usrn">
							<i class="fas fa-user"
								style="font-size: 25px; color: black !important;"></i>
						</div>
						<c:if test="${not empty userobj }">
							<a href="checkout.jsp"
								class="nav-cart"><i
								class="fa-solid fa-cart-shopping"></i></a>
						</c:if>
					</div>

				</div>

				<div class="tooltiptext-1">
					<div>
						<c:if test="${not empty userobj }">
							<div class="item-user">
								<a href="setting.jsp" class="usrn"><i>${userobj.name }</i></a>
							</div>
							<div class="item-user">
								<a href="edit_profile.jsp" class="usrn">Edit Profile</a>
							</div>
							<div class="item-user">
								<a href="order.jsp" class="usrn">My order</a>
							</div>
							<div class="item-user">
								<a href="user_address.jsp" class="usrn">Your Address</a>
							</div>
							<div class="item-user">
								<a href="sell_fashion.jsp" class="usrn">Sell Fashion</a>
							</div>
							<div class="item-user">
								<a href="old_fashion.jsp" class="usrn">Old Fashion</a>
							</div>
							<div class="item-user"
								style="border: none; background-color: none;">
								<a data-toggle="modal" data-target="#exampleModalCenter"
									class="logout" style="font-size: 16px !important;">Logout</a>
							</div>
						</c:if>
						<c:if test="${empty userobj }">
							<div class="item-user">
								<a href="login.jsp" class="login">Login</a>
							</div>

							<div class="item-user" style="border: none;">
								<a href="register.jsp" class="login">Register</a>
							</div>
						</c:if>
					</div>
				</div>
			</div>


		</div>

	</div>
</div>


<!-- Logout modal Nguyen Quang Huong-->



<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="text-center">
					<h4>Do you want logout?</h4>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<a href="logout" type="button" class="btn btn-primary">Logout</a>
				</div>
			</div>
			<div class="modal-footer"></div>
		</div>
	</div>
</div>

<!-- End modal -->





<nav class="navbar navbar-expand-lg navbar-dark bg-custom" style="">
	<a class="navbar-brand" href="index.jsp"><i
		class="fa-solid fa-house"></i></a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-h nav-item active"><a class="nav-link"
				href="index.jsp">HOME <span class="sr-only">(current)</span>
			</a></li>
			<li class="nav-h nav-item"><a class="nav-link"
				href="all_recent_fashion.jsp">RECENT FASHION </a></li>
			<li class="nav-h nav-item"><a class="nav-link"
				href="all_new_fashion.jsp">NEW FASHION </a></li>

			<li class="nav-h nav-item"><a class="nav-link"
				href="all_old_fashion.jsp">OLD FASHION</a></li>
				
			<li class="nav-h nav-item text-uppercase"><a class="nav-link"
				href="helpline.jsp">Contact</a></li>
		</ul>
	</div>
</nav>


<script>
	const user = document.querySelector('.usrn');
	const tooltip = document.querySelector('.tooltiptext-1');
	var count = 0;
	user.onclick = function() {
		if (count % 2 === 0)
			tooltip.style.visibility = "visible";
		else
			tooltip.style.visibility = "hidden";
		count++;
	}
</script>