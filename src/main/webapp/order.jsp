

<%@page import="java.util.List"%>
<%@page import="com.entity.Fashion_Order"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.DAO.FashionOrderDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Order Fashion</title>
<%@include file="all_component/allCss.jsp"%>
<link rel="stylesheet" href="all_component/userPageStyle.css">
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
	font-size: 20px;
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



</style>

<body style="background-color: #f0f1f2;">
	<%@include file="all_component/navbar.jsp"%>
	
	<div class="user-content-main">
	<%@include file="all_component/nav-user-page.jsp" %>
	<div class="user-content">
		<table >
			<thead >
				<tr>
					<th scope="col">#ID</th>
					<th scope="col">Sản Phẩm</th>
					<th scope="col">Giá</th>
					<th scope="col">Payment Type</th>
					<th scope="col">Ngày đặt hàng</th>
				</tr>
			</thead>
			<tbody>
				<%
				FashionOrderDAOImpl dao = new FashionOrderDAOImpl(DBConnect.getConn());
				List<Fashion_Order> flist = dao.getAllOrder();
				for (Fashion_Order f : flist) {
				%>
				<tr>
					<td scope="row" style="font-family:'Roboto',san-serif;">#<%=f.getOrderId()%></td>
					<td style="width:20%;font-family:'Roboto',san-serif;font-weight:650;"><%=f.getFashionName()%>, Size: <%=f.getSize()%>, SL: <%=f.getQuantity() %></td>
					<td style="color:#ff0000;font-weight:600;"><%=f.getPrice()%><span style="text-decoration:underline;">đ</span></td>
					<td style="font-family:'Roboto',san-serif;font-weight:650;"><%=f.getPaymentType() %></td>
					<td style="font-family:'Roboto',san-serif;font-weight:600;"><%=f.getDate()%></td>
				</tr>
				<%
				}
				%>

			</tbody>
		</table>

	</div>
	</div>
	<%@include file="all_component/footer.jsp"%>
</body>
<script>
	const items = document.querySelectorAll('.nav-ver.nav-link') ;
	items[1].classList.add('active');
	const text = document.querySelector('.nav-ver.nav-link.active').innerHTML;
	document.getElementById('direction').innerHTML = text;
</script>

</html>
