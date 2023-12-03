<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%@ page import="com.DAO.*"%>
<%@ page import="com.entity.*"%>
<%@ page import="com.DAO.FashionDAOImpl.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.DB.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin: Tất cả sản phẩm</title>
<%@include file="allCss.jsp"%>
</head>

<style>
table {
	border-collapse: collapse;
	width: 100%;
}

th, td {
	padding: 8px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

th {
	font-size: 18px;
	color: black !important;
	font-weight: 700 !important;
	font-family: 'Roboto', sans-serif;
	font-weight: 500;
}

}
td {
	font-family: 'Roboto', sans-serif !important;
	color: black !important;
	font-size: 18px !important;
}

.info-product {
	display: flex;
	align-items: center;
}

.edit {
	color: black;
	font-size: 20px;
	transition: all 0.4s ease-in-out;
	margin: 0 10px;
}

.delete {
	color: black;
	font-size: 20px;
}

.edit:hover, .delete:hover {
	font-size: 23px;
	color: #ccc;
	text-decoration: none;
}
</style>

<body>
	<%@include file="navbar.jsp"%>
	<c:if test="${empty userobj}">
		<c:redirect url="../login.jsp" />
	</c:if>
	<c:if test="${not empty succMsg }">
		<h5 class="text-center text-success">${succMsg }</h5>
		<c:remove var="succMsg" scope="session" />
	</c:if>
	<c:if test="${not empty failedMsg }">
		<h5 class="text-center text-dangers">${failedMsg }</h5>
		<c:remove var="failedMsg" scope="session" />
	</c:if>
	<div class='dashboard'>
		<div class="dashboard-nav">
			<header>
				<a href="#!" class="menu-toggle"><i class="fas fa-bars"></i></a><a
					href="#" class="brand-logo"><i class="fa-regular fa-heart"></i>
					<span class="brand">GROUP 6F</span></a>
			</header>
			<nav class="dashboard-nav-list">
				<a href="home.jsp" class="dashboard-nav-item"><i
					class="fas fa-home"></i> Home </a>
				<div class='dashboard-nav-dropdown'>
					<a href="#!"
						class="dashboard-nav-item dashboard-nav-dropdown-toggle"><i
						class="fas fa-tachometer-alt"></i>Dashboard</a>
					<div class='dashboard-nav-dropdown-menu'>
						<a href="bestSeller.jsp" class="dashboard-nav-dropdown-item">Best
							Seller</a><a href="userRank.jsp" class="dashboard-nav-dropdown-item">User Rank</a>
					</div>
				</div>
				<a href="add_fashions.jsp" class="dashboard-nav-item"><i
					class="fa-solid fa-circle-plus"></i>Thêm sản phẩm </a> <a
					href="all_fashions.jsp" class="dashboard-nav-item"><i
					class="fa-solid fa-layer-group"></i> Tất cả sản phẩm</a> <a
					href="all_order.jsp" class="dashboard-nav-item"><i
					class="fa-solid fa-users"></i> Đơn đặt hàng </a><a href="#"
					class="dashboard-nav-item"><i class="fas fa-user"></i> Profile
				</a>

				<div class="nav-item-divider"></div>
				<a href="../logout" class="dashboard-nav-item logout"><i
					class="fas fa-sign-out-alt"></i> Logout </a>

			</nav>
		</div>
		<div class='dashboard-app'>
			<header class='dashboard-toolbar'>
				<a href="#!" class="menu-toggle"><i class="fas fa-bars"></i></a>
			</header>
			<div class='dashboard-content'>
				<div class='container'>
					<div class='card'>
						<div class='card-header'>
							<h1>TẤT CẢ SẢN PHẨM</h1>
						</div>
						<div class='card-body'>
							<table class="table table-striped">
								<thead class="bg-primary text-white">
									<tr>
										<th scope="col">#ID</th>
										<th scope="col">SẢN PHẨM</th>
										<th scope="col">GIÁ</th>
										<th scope="col">TRẠNG THÁI</th>
										<th scope="col" style="text-align: center;">CÔNG CỤ</th>

									</tr>
								</thead>
								<!-- Nguyen Quang Huong -->
								<tbody>
									<%
									FashionDAOImpl dao = new FashionDAOImpl(DBConnect.getConn());
									List<FashionDtls> list = dao.getAllFashions();
									for (FashionDtls b : list) {
									%>
									<tr>
										<td>#<%=b.getFashionId()%></td>
										<td class="info-product" style="color: black;"><img
											src="../fashion/<%=b.getPhotoName()%>"
											style="width: 50px; height: 50px;"><%=b.getFashionName()%>,
											Size: <%=b.getSize()%>, SL: <%=b.getQuantity()%>, Loại: <%=b.getFashionCategory()%>
										</td>

										<td style="color: #ff0000; font-weight: 600;"><%=b.getPrice()%><span
											style="text-decoration: underline;">đ</span></td>
										<td style="color: #03c03c;"><%=b.getStatus()%></td>

										<td style="text-align: center;"><a
											href="edit_fashions.jsp?id=<%=b.getFashionId()%>"
											class="edit"><i class="fas fa-edit"></i> </a> <a
											href="../delete?id=<%=b.getFashionId()%>" class="delete"><i
												class="fas fa-trash-alt"></i> </a></td>
									</tr>
									<%
									}
									%>


								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>