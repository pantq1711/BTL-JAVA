<%@ page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.DAO.*"%>
<%@ page import="com.DAO.FashionDAOImpl.*"%>
<%@ page import="com.entity.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.DB.*"%>
<%@ page import="com.DB.DBConnect.*"%>


<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta charset="ISO-8859-1">
<title>Fashion: Index</title>
<%@ include file="all_component/allCss.jsp"%>
<style type="text/css">
.slider div, .slider div img {
	height: 100vh;
	width: 100%;
}

.slider {
	position: relative;
}

.slick-next.slick-custom.slick-arrow {
	position: absolute;
	font-size: 20px;
	top: 45%;
	border: 5px solid rgba(0, 0, 0, 0.5);
	width: 60px;
	right: 10px;
	transition: all 0.3s ease;
	font-weight: 550;
}

.slick-prev.slick-custom.slick-arrow {
	position: absolute;
	font-size: 20px;
	width: 60px;
	border: 5px solid rgba(0, 0, 0, 0.5);
	top: 45% !important;
	left: 10px;
	z-index: 2;
	transition: all 0.3s ease;
}

.slick-next.slick-custom.slick-arrow:hover {
	background-color: black !important;
	color: white !important;
}

.slick-prev.slick-custom.slick-arrow:hover {
	background-color: black !important;
	color: white !important;
}

.slick-dots {
	position: absolute;
	display: flex;
	list-style-type: none;
	left: 50%;
	transform: translateX(-50px);
	bottom: 25px;
}

.slick-dots li button {
	margin-left: 5px;
	font-size: 0;
	width: 15px;
	height: 15px;
	border-radius: 50%;
	/* border: none; */
	outline: none;
	border: 3px solid #555555;
	opacity: 0.5;
	background-color: rgba(0, 0, 0, 0);
}

.slick-dots .slick-active button {
	/* border: 3px solid#fff; */
	background-color: white;
	border: 3px solid white;
	opacity: 1;
	outline: none;
}
/* Title Fashion */
.container .title-fashion {
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 40px 0;
}

.container .title-fashion .decoration {
	font-size: 0;
	height: 2px;
	width: 30%;
	background-color: rgba(0, 0, 0, 0.4);
	flex-grow: 1;
}

.container .title-fashion .title-1 {
	flex-grow: 1;
	font-size: 30px;
	text-align: center;
	color:rgb(3, 78, 180) !important;
}

.crd-ho:hover {
	background: #fcf7f7;
}

.btn {
	background-color: rgba(0, 0, 0, 0.9);
	border: none;
}

.btn {
	color: white;
}

.price.btn {
	width: 60%;
}

.container {
	margin-top: 40px;
}
</style>
</head>
<body>

	<%
	User u = (User) session.getAttribute("userobj");
	%>
	<%@ include file="all_component/navbar.jsp"%>
	<%@ include file="all_component/allCss.jsp"%>
	<div class="slider">
		<div>
			<img src="img/backg3.webp">
		</div>
		<div>
			<img src="img/backg2.png">
		</div>
	</div>

	<!-- Start Recent Fashion -->
	<!-- Nguyen Quang Huong -->
	<div class="container">
		<div class="title-fashion">
			<div class="decoration">h</div>
			<div class="title-1">RECENT FASHION</div>
			<div class="decoration">h</div>
		</div>

		<div class="list-items row" style="padding: 0;">
			<%
			FashionDAOImpl dao2 = new FashionDAOImpl(DBConnect.getConn());
			List<FashionDtls> list2 = dao2.getRecentFashions();
			for (FashionDtls b : list2) {
			%>
			<div class="items col-md-auto"
				style="padding: 0; margin: 0 5px; width: 20% !important;">
				<div class="cart-user" style="padding: 0; width: 100%;">
					<div class="card-body" style="padding: 0; width: 100%;">
						<img alt="" src="fashion/<%=b.getPhotoName()%>"
							style="width: 100%; height: fit-object;">
						<div class="inf-product" style="padding: 10px;">

							<p class="name"><%=b.getFashionName()%></p>
							<p>
								<%
								if (b.getFashionCategory().equals("Cũ")) {
								%>
								Categories:<span style="color: rgba(0, 0, 0, 0.6);';"><%=b.getFashionCategory()%></span>
							</p>
							<p class="text-left">
								<span class="root-price"
									style="text-decoration: line-through; color: rgba(255, 133, 71, 0.7);"><%=b.getPrice()%>vnd</span>
								<span class="sale-price"><%=b.getPrice()%> vnd</span>
							</p>


							<div class="view-class row">
								<a href="view_fashions.jsp?fid=<%=b.getFashionId()%>"
									class="btn btn-success btn-sm ml-5"><i
									class="fa-solid fa-eye"></i></a>
							</div>

							<%
							} else {
							%>
							Categories:<span style="color: rgb(26, 223, 34);';"><%=b.getFashionCategory()%></span>
							<div class="view-class row">
								<a href="view_fashions.jsp?fid=<%=b.getFashionId()%>"
									class="btn btn-success btn-sm ml-5"><i
									class="fa-solid fa-eye"></i></a>
							</div>
							<p class="text-left">
								<span class="root-price"
									style="text-decoration: line-through; color: rgba(255, 133, 71, 0.7)"><%=b.getPrice()%>vnd</span>
								<span class="sale-price"><%=b.getPrice()%> vnd</span>
							</p>

							<div class="cart-parent row">

								<%
								if (u == null) {
								%>
								<div class="cart-icon">
									<a href="login.jsp"
										class="cart-link btn btn-danger btn-sm ml-2"><i
										class="fa-solid fa-cart-plus"
										style="background-color: rgba(0, 0, 0, 0.9); border: none;"></i></a>
								</div>
								<%
								} else {
								%>
								<div class="cart-icon">
									<a href="cart?fid=<%=b.getFashionId()%>&&uid=<%=u.getId()%>"
										class="cart-link btn btn-danger btn-sm ml-2"
										style="background-color: rgba(0, 0, 0, 0.9); border: none;"><i
										class="fa-solid fa-cart-plus"></i></a>
								</div>
								<%
								}
								%>

							</div>
							<%
							}
							%>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			%>
		</div>

		<div class="view-all text-center mt-1">
			<a href="all_recent_fashion.jsp"
				class="btn btn-danger btn-sm text-white">View All <i
				class="fa-solid fa-arrow-right"></i></a>
		</div>
	</div>
	<!-- End Recent Fashion -->

	<hr>

	<!-- Start New Fashion -->
	<!-- Nguyen Quang Huong -->
	<div class="container">
		<div class="title-fashion">
			<div class="decoration">h</div>
			<div class="title-1">NEW FASHION</div>
			<div class="decoration">h</div>
		</div>

		<div class="list-items row" style="padding: 0;">
			<%
			FashionDAOImpl dao3 = new FashionDAOImpl(DBConnect.getConn());
			List<FashionDtls> list3 = dao3.getNewFashion();
			for (FashionDtls b : list3) {
			%>
			<div class="items col-md-2"
				style="padding: 0; margin: 0 5px; max-width: 25% !important;">
				<div class="cart-user" style="padding: 0; width: 100%;">
					<div class="card-body" style="padding: 0; width: 100%;">
						<img alt="" src="fashion/<%=b.getPhotoName()%>"
							style="width: 100%; height: fit-object;">
						<div class="inf-product" style="padding: 10px;">

							<p class="name"><%=b.getFashionName()%></p>
							<p>
								Categories:<span style="color: rgb(26, 223, 34);';"><%=b.getFashionCategory()%></span>
							<div class="view-class row">
								<a href="view_fashions.jsp?fid=<%=b.getFashionId()%>"
									class="btn btn-success btn-sm ml-5"><i
									class="fa-solid fa-eye"></i></a>
							</div>
							<p class="text-left">
								<span class="root-price"
									style="text-decoration: line-through; color: rgba(255, 133, 71, 0.7)"><%=b.getPrice()%>vnd</span>
								<span class="sale-price"><%=b.getPrice()%> vnd</span>
							</p>

							<div class="cart-parent row">

								<%
								if (u == null) {
								%>
								<div class="cart-icon">
									<a href="login.jsp"
										class="cart-link btn btn-danger btn-sm ml-2"><i
										class="fa-solid fa-cart-plus"
										style="background-color: rgba(0, 0, 0, 0.9); border: none;"></i></a>
								</div>
								<%
								} else {
								%>
								<div class="cart-icon">
									<a href="cart?fid=<%=b.getFashionId()%>&&uid=<%=u.getId()%>"
										class="cart-link btn btn-danger btn-sm ml-2"
										style="background-color: rgba(0, 0, 0, 0.9); border: none;"><i
										class="fa-solid fa-cart-plus"></i></a>
								</div>
								<%
								}
								%>
							</div>

						</div>
					</div>
				</div>
			</div>
			<%
			}
			%>
		</div>

		<div class="view-all text-center mt-1">
			<a href="all_new_fashion.jsp"
				class="btn btn-danger btn-sm text-white">View All <i
				class="fa-solid fa-arrow-right"></i></a>
		</div>
	</div>
	<!-- End New Fashion -->

	<hr>

	<!-- Start Old Fashion -->
	<div class="container">
		<div class="title-fashion">
			<div class="decoration">h</div>
			<div class="title-1">OLD FASHION</div>
			<div class="decoration">h</div>
		</div>

		<div class="list-items row" style="padding: 0;">
			<%
			FashionDAOImpl dao4 = new FashionDAOImpl(DBConnect.getConn());
			List<FashionDtls> list4 = dao4.getOldFashions();
			for (FashionDtls b : list4) {
			%>
			<div class="items col-md-2"
				style="padding: 0; margin: 0 5px; max-width: 25% !important;">
				<div class="cart-user" style="padding: 0; width: 100%;">
					<div class="card-body" style="padding: 0; width: 100%;">
						<img alt="" src="fashion/<%=b.getPhotoName()%>"
							style="width: 100%; height: fit-object;">
						<div class="inf-product" style="padding: 10px;">

							<p class="name"><%=b.getFashionName()%></p>
							<p>
								Categories:<span style="color: rgba(0,0,0,0.6);"><%=b.getFashionCategory()%></span>
							<div class="view-class row">
								<a href="view_fashions.jsp?fid=<%=b.getFashionId()%>"
									class="btn btn-success btn-sm ml-5"><i
									class="fa-solid fa-eye"></i></a>
							</div>
							<p class="text-left">
								<span class="root-price"
									style="text-decoration: line-through; color: rgba(255, 133, 71, 0.7)"><%=b.getPrice()%>vnd</span>
								<span class="sale-price"><%=b.getPrice()%> vnd</span>
							</p>

							

						</div>
					</div>
				</div>
			</div>
			<%
			}
			%>
		</div>

		<div class="view-all text-center mt-1" style="margin-bottom:40px !important;">
			<a href="all_old_fashion.jsp"
				class="btn btn-danger btn-sm text-white">View All <i
				class="fa-solid fa-arrow-right"></i></a>
		</div>
	</div>
	<!-- End Old Fashion -->

	<%@ include file="all_component/footer.jsp"%>
	

</body>

<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){
    $('.slider').slick({
        infinite:true,
        slidesToShow:1,
        slidesToScroll:1,
        prevArrow:`
        <button type="button" class="slick-prev slick-custom" style="border-radius:50%;  background-color:rgba(255,255,255,0); padding : 10px 15px;  "><i class="fa-solid fa-angle-left"></i></button>
        `,
        nextArrow:`
        <button type="button" class="slick-next slick-custom" style="border-radius:50%;  background-color:rgba(255,255,255,0); padding : 10px 15px; "><i class="fa-solid fa-chevron-right"></i></button>
        `,
        dots:true
    });
  });
  </script>
</html>
