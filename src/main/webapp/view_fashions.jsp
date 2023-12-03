<%-- 
    Document   : view_fashion
    Created on : Nov 14, 2023, 9:47:59 PM
    Author     : Anphan
--%>
<%@ page import="java.util.*"%>
<%@ page import="com.DAO.*"%>
<%@ page import="com.DAO.FashionDAOImpl.*"%>
<%@ page import="com.entity.*"%>
<%@ page import="com.DB.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<%@include file="all_component/allCss.jsp"%>
<link rel="stylesheet" href="all_component/viewStyle.css">

<style>
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
	color: rgb(3, 78, 180) !important;
}

.container {
	position: relative !important;
}

.slick-next.slick-custom.slick-arrow {
	position: absolute;
	font-size: 20px;
	top: 45% !important;
	border: none !important;
	width: 25px;
	right: -22px;
	transition: all 0.3s ease;
	font-weight: 550;
}

.slick-prev.slick-custom.slick-arrow {
	position: absolute !important;
	left: -30px;
	top: 45% !important;
	z-index: 10;
	font-size: 20px;
	width: 25px;
	border: none !important;
	top: 45% !important;
	transition: all 0.3s ease;
}


.slick-next.slick-custom.slick-arrow:hover {
	border:none !important;
	opacity: 0.6;
	transform: scale(1.2);
}

.slick-prev.slick-custom.slick-arrow:hover {
	border:none !important;
	opacity: 0.6;
	transform: scale(1.2);
}

</style>
</head>
<body>
	<%@include file="all_component/navbar.jsp"%>
	<%
	User u = (User) session.getAttribute("userobj");
	%>
	<%
	int bid = Integer.parseInt(request.getParameter("fid"));
	FashionDAOImpl dao = new FashionDAOImpl(DBConnect.getConn());
	FashionDtls b = dao.getFashionById(bid);
	%>

	<div class="view-product container">
		<div class="details row">
			<div class="img-view col-md-6 p-5 bg-white"
				style="max-width: 40% !important;">
				<img src="fashion/<%=b.getPhotoName()%>"
					style="height: fit-object; width: 100%"><br>
				<%-- <h4 class="mt-3">
					Fashion Name:<span class="text-success"><%=b.getFashionName()%>
					</span>
				</h4>
				<h4>
					Size Name:<span class="text-success"><%=b.getSize()%></span>
				</h4>
				<h4>
					Category:<span class="text-success"><%=b.getFashionCategory()%></span>
				</h4> --%>
			</div>
			<div class="inf-view col-md-6 p-5 bg-white">
				<h2 class="info-1"><%=b.getFashionName()%></h2>
				<p class="info info-1">
					<span class="root-price"
						style="text-decoration: line-through; color: rgba(255, 133, 71, 0.7);"><%=b.getPrice()%>vnd</span>
					<span class="sale-price"><%=b.getPrice()%> vnd</span>
				</p>

				<%
				if ("Cũ".equals(b.getFashionCategory())) {
				%>
				<h5 class="text-primary info-1">Contact To Seller</h5>
				<h5 class="text-primary info-1">
					<i class="far fa-envelope"></i> Email:
					<%=b.getEmail()%></h5>
				<%
				}
				%>

				<div class="info info-1">
					<p>
						Category:<span class="text-success"><%=b.getFashionCategory()%></span>
					</p>
				</div>
				<div class="info info-1">
					<p>
						Code: <span>N/A</span>
					</p>
				</div>
				<div class="status info-1">
					<p>
						Action: <span style="color: black;">Active</span>
					</p>
				</div>

				<div class="size-view">
					<p>
						SIZE: <span class="size-option"><%=b.getSize()%></span>
					</p>

				</div>


				<%
				if ("Old".equals(b.getFashionCategory())){
				%>
				<div class="continue">
					<a href="index.jsp" class="btn btn-success">Continue Shopping</a>
				</div>
				<%
				} else {
				%>
				<%
				if (u != null) {
				%>
				<div class="addition-product">
					<a href="cart?fid=<%=b.getFashionId()%>&&uid=<%=u.getId()%>"
						class="addC text-center text-uppercase btn btn-primary"> ADD
						CART</a>
				</div>
				<%
				} else {
				%>
				<div class="addition-product">
					<a href="login.jsp"
						class="addC text-center text-uppercase btn btn-primary"> ADD
						CART</a>
				</div>

				<%
				}
				%>
				<%
				}
				%>
			</div>
		</div>
	</div>

	<div class="description container">
		<h3 class="title-d text-uppercase text-left">Product detail
			information</h3>
		<p class="pra-des text-left" style="font-size:18px;"><%=b.getDescribe() %></p>
	</div>

	<div class="container">
		<div class="title-fashion">
			<div class="decoration">h</div>
			<div class="title-1 text-uppercase">Relation FASHION</div>
			<div class="decoration">h</div>
		</div>
		<div class="list-relation row p-3">
			<%
			FashionDAOImpl dao2 = new FashionDAOImpl(DBConnect.getConn());
			List<FashionDtls> list2 = dao2.getAllRecentFashion();
			for (FashionDtls b1 : list2) {
			%>
			<div class="items col-md-auto" style="padding: 0; margin: 5px 5px;">
				<div class="cart-user" style="padding: 0; width: 100%;">
					<div class="card-body" style="padding: 0; width: 100%;">
						<img alt="" src="fashion/<%=b1.getPhotoName()%>"
							style="width: 100%; height: fit-object;">
						<div class="inf-product" style="padding: 10px;">

							<p class="name"><%=b1.getFashionName()%></p>
							<p>
								<%
								if (b1.getFashionCategory().equals("Old")) {
								%>
								Categories:<span style="color: rgba(0, 0, 0, 0.6);';"><%=b1.getFashionCategory()%></span>
							</p>
							<p class="text-left">
								<span class="root-price"
									style="text-decoration: line-through; color: rgba(255, 133, 71, 0.7);"><%=b.getPrice()%>vnd</span>
								<span class="sale-price"><%=b1.getPrice()%> vnd</span>
							</p>


							<div class="view-class row">
								<a href="view_fashions.jsp?fid=<%=b1.getFashionId()%>"
									class="btn btn-success btn-sm ml-5"><i
									class="fa-solid fa-eye"></i></a>
							</div>

							<%
							} else{
							%>
							Categories:<span style="color: rgb(26, 223, 34);';"><%=b1.getFashionCategory()%></span>
							<div class="view-class row">
								<a href="view_fashions.jsp?fid=<%=b1.getFashionId()%>"
									class="btn btn-success btn-sm ml-5"><i
									class="fa-solid fa-eye"></i></a>
							</div>
							<p class="text-left">
								<span class="root-price"
									style="text-decoration: line-through; color: rgba(255, 133, 71, 0.7)"><%=b.getPrice()%>vnd</span>
								<span class="sale-price"><%=b1.getPrice()%> vnd</span>
							</p>

							<div class="cart-parent row">

								<%
								if (u == null) {
								%>
								<div class="cart-icon">
									<a href="login.jsp"
										class="cart-link btn btn-danger btn-sm ml-2"><i
										class="fa-solid fa-cart-plus"
										style="background-color: rgba(0, 0, 0, 0.7); border: none;"></i></a>
								</div>
								<%
								} else {
								%>
								<div class="cart-icon">
									<a href="cart?fid=<%=b1.getFashionId()%>&&uid=<%=u.getId()%>"
										class="cart-link btn btn-danger btn-sm ml-2"
										style="background-color: rgba(0, 0, 0, 0.7); border: none;"><i
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
	</div>


	<%@include file="all_component/footer.jsp"%>
</body>

<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){
    $('.list-relation').slick({
        infinite:true,
        slidesToShow:4,
        slidesToScroll:1,
        prevArrow:`
        <button type="button" class="slick-prev slick-custom" style="focus:border:none !important;background-color:rgba(255,255,255,0); "><i class="fa-solid fa-angle-left"></i></button>
        `,
        nextArrow:`
        <button type="button" class="slick-next slick-custom" style="focus:border:none !important;background-color:rgba(255,255,255,0);"><i class="fa-solid fa-chevron-right"></i></button>
        `
    });
  });
  </script>
</html>