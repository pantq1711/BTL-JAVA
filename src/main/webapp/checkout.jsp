<%@page import="java.util.List"%>
<%@page import="com.DAO.*"%>
<%@page import="com.DB.*"%>
<%@page import="com.entity.*"%>
<%@page import="java.text.*"  %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<script>
	function validateQuantity(input) {
		var maxQuantity = parseInt(input.max);
		var enteredQuantity = parseInt(input.value);

		if (enteredQuantity > maxQuantity) {
			input.value = maxQuantity;
		}
	}
</script>

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
	font-size: 25px;
	color: black !important;
	font-weight: 700 !important;
	font-family: 'Roboto', sans-serif;
	font-weight: 500;
}

}
td {
	font-family: 'Roboto', sans-serif;
	color: black;
	font-size: 18px;
}

.list-and-inf {
	display: flex;
	justify-content: center;
	flex-direction: row;
}

.list-order {
	flex-grow: 2;
}

.info-user {
	flex-grow: 1;
}

.title-cart {
	font-size: 30px;
	text-align: center;
	margin: 20px 0;
}

.list-order, .info-user {
	margin: 20px;
}

.info-product {
	widht: 30%;
}

.price-product {
	width: 20%;
}

.quatity {
	width: 30%;
}

.counter {
	width: 150px;
	display: flex;
}

.counter input {
	width: 50px;
	border: 0.5px solid #ccc;
	line-height: 30px;
	font-size: 20px;
	background: white;
	color: black;
	text-align: center;
	appearance: none;
	outline: 0;
	appearance: none;
}

.counter span {
	display: block;
	font-size: 25px;
	padding: 0 10px;
	cursor: pointer;
	color: black !important;
	user-select: none;
}

.delete-order {
	transition: all 0.3s linear;
}

.delete-order:hover {
	opacity: 0.6;
}

input[type=number]::-webkit-inner-spin-button {
	-webkit-appearance: none;
}

.title-info {
	padding: 8px;
	text-align: left;
	border-bottom: 1px solid #ddd;
	font-size: 25px;
	color: black !important;
	font-weight: 700 !important;
	font-family: 'Roboto', sans-serif;
	font-weight: 500;
}

label{
	font-size:20px !important;
	font-weight:600;
}

.method button:hover{
	background:#ccc ;
	color:back;
}

.method a:hover{
	background-color:#ccc !important;
	color:black !important;
}

.info-user input{
box-shadow: rgba(50, 50, 93, 0.25) 0px 2px 5px -1px, rgba(0, 0, 0, 0.3) 0px 1px 3px -1px;
border:none;
}

.info-user input:focus{
  border:none !important;
  box-shadow: rgba(6, 24, 44, 0.4) 0px 0px 0px 2px, rgba(6, 24, 44, 0.65) 0px 4px 6px -1px, rgba(255, 255, 255, 0.08) 0px 1px 0px inset;
  
}

.calc:hover{
	text-decoration:none;
	color:rgba(0,0,0,0) !important;
}
/* .content-checkout {
	display: inline:block;
	width: 40%;
}

.list-order {
	display: inline-block;
	width: 100%;
}

.info-user {
	display: inline-block;
	width: 40%;
	float: right;
} */
</style>
<meta charset="ISO-8859-1">
<title>Giỏ hàng</title>
<%@include file="all_component/allCss.jsp"%>
</head>
<body style="background-color: white !important;" onload="loadScroll()" onunload="saveScroll()">
	<%@include file="all_component/navbar.jsp"%>
	<c:if test="${empty userobj}">
		<c:redirect url="login.jsp"></c:redirect>
	</c:if>

	<c:if test="${not empty succMsg}">
		<div class="alert alert-success" role="alert">${succMsg}</div>
		<c:remove var="succMsg" scope="session" />
	</c:if>

	<c:if test="${not empty failedMsg}">
		<div class="alert alert-danger text-center" role="alert">${failedMsg}</div>
		<c:remove var="failedMsg" scope="session" />
	</c:if>

	<div class="title-cart text-uppercase">Giỏ Hàng</div>

	<div class="list-and-inf">
		<div class="list-order">
			<table>
				<thead>
					<tr>
						<th scope="col">Sản phẩm</th>
						<th scope="col">Giá</th>
						<th scope="col">Số lượng</th>
					</tr>
				</thead>

				<tbody>
					<%
					User u = (User) session.getAttribute("userobj");
					CartDAOImpl dao = new CartDAOImpl(DBConnect.getConn());
					List<Cart> cart = dao.getFashionByUser(u.getId());
					FashionDAOImpl dao1 = new FashionDAOImpl(DBConnect.getConn());
					Double totalPrice = 0.00;
					int count = 1;
					DecimalFormat formatter = new DecimalFormat("###,###,###,###");
				    
					for (Cart c : cart) {
						FashionDtls f = dao1.getFashionById(c.getFid());
						totalPrice += (Double.parseDouble(c.getPrice())*c.getQuantity());
					%>
					<tr>
						<td class="info-product">
							<img alt="" src="fashion/<%=f.getPhotoName()%>"

							style="width: 100px; height: 100px;"><%=c.getFashionName()%>,
							<%=c.getSize()%></td>
						<td class="price-product"><span
							style="color: #ff0000; font-weight: 600;'"><%=c.getPrice()%><span
								style="text-decoration: underline;">đ</span></span></td>
						<td class="quantity">
							<div class="counter">
								<a href="subcart?fid=<%=c.getFid()%>&&cid=<%=c.getCid()%>" class="calc"><span class="down" onClick='decreaseCount(event, this)'>-</span></a>
								<input type="number" name="quantity_<%=c.getCid()%>" value="<%=c.getQuantity() %>"
									oninput="validateQuantity(this)"> <a href="addcart?fid=<%=c.getFid()%>&&cid=<%=c.getCid()%>" class="calc"><span class="up"
									onClick='increaseCount(event, this)'>+</span> </a><!-- <span class="up"
									onClick='increaseCount(event, this)'>+</span> --> <a
									style="color: black; font-size: 25px !important;"
									href="remove_fashion?fid=<%=c.getFid()%>&&uid=<%=c.getUserId()%>&&cid=<%=c.getCid()%>"
									class="delete-order text-center"><i
									class="fas fa-trash-alt"></i></a>
							</div> <%-- <input type="number" style="visibility: hidden;"
							name="quantity_<%=c.getCid()%>" value="" min="1"
							max="<%=c.getQuantity()%>" oninput="validateQuantity(this)"> --%>

						</td>


					</tr>
					<%
					count++;
					}
					%>
					<tr>
						<td style="font-size: 25px;">Tổng giá tiền</td>
						<td
							style="color: #ff0000; text-align: center; font-size: 25px; font-weight: 700;"><%=formatter.format(totalPrice)%><span
							style="text-decoration: underline;">đ</span></td>
					</tr>
				</tbody>

			</table>
		</div>
		<div class="info-user">
			<div class="title-info">Thanh Toán</div>
			<form action="order" method="post" style="margin-top:10px;">
				<input type="hidden" value="${userobj.id}" name="id">
				<div class="form-row">
				<div class="form-group col-md-6">
					<label for="inputEmail4">Họ tên*</label> <input type="text"
						name="username" class="form-control" id="inputEmail4"
						value="${userobj.name}" required>
				</div>
				<div class="form-group col-md-6">
					<label for="inputEmail4">Email*</label> <input type="email"
						name="email" class="form-control" id="inputPassword4"
						value="${userobj.email}" required>
				</div>
				</div>
				<div class="form-group">
					<label for="inputEmail4">Số điện thoại*</label> <input type="number"
						name="phno" class="form-control" id="inputEmail4"
						value="${userobj.phno}" required>

					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="inputEmail4">Số nhà</label> <input type="text"
								name="numhouse" class="form-control" id="inputEmail4"
								value="${userobj.numhouse}" required>
						</div>

						<div class="form-group col-md-6">
							<label for="inputEmail4">Địa chỉ</label> <input type="text"
								name="address" class="form-control" id="inputPassword4 "
								value="${userobj.address}" required>
						</div>
					</div>
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="inputEmail4">Thành phố</label> <input type="text"
								name="city" class="form-control" id="inputPassword4"
								value="${userobj.city}" required>
						</div>
						<div class="form-group col-md-6">
							<label for="inputEmail4">Tỉnh</label> <input type="text"
								name="province" class="form-control" id="inputEmail4"
								value="${userobj.province}" required>
						</div>
					</div>
					<div class="from-group">
					<label>Phương thức thanh toán</label> <select class="form-control"
						name="paymentType">
						<option value="COD">COD</option>
						<option value="QR">Bank Transfer</option>
					</select>
				</div>
				</div>
				<input type="hidden" id="timeorder" name="timeorder" />
				<!-- Add the rest of your form fields here -->
				<div class="method text-center">
					<button class="btn text-uppercase" onclick="if (kiemTraThanhToan()) { layThoiGianOrder(); }" style="margin:10px;font-size:20px">Đặt hàng</button>
					<a href="index.jsp" class="btn text-uppercase" style="margin:10px; font-size:20px">Tiếp tục mua hàng</a>
				</div>
			</form>
		</div>
	</div>


</body>


<script>
	function increaseCount(a, b) {
		var input = b.previousElementSibling;
		var value = parseInt(input.value, 10);
		value = isNaN(value) ? 0 : value;
		value++;
		input.value = value;
	}

	function decreaseCount(a, b) {
		var input = b.nextElementSibling;
		var value = parseInt(input.value, 10);
		if (value > 1) {
			value = isNaN(value) ? 0 : value;
			value--;
			input.value = value;
		}
	}

	function layThoiGianOrder() {
		var thoiGianHienTai = new Date();
		var ngay = thoiGianHienTai.getDate();
		var thang = thoiGianHienTai.getMonth() + 1;
		var nam = thoiGianHienTai.getFullYear();
		var thoiGianOrder = ngay + '/' + thang + '/' + nam;
		document.getElementById("timeorder").value = thoiGianOrder;
	}
	
	function kiemTraThanhToan() {
		var phuongThucThanhToan = document.getElementsByName("paymentType")[0].value;
		if (phuongThucThanhToan === "noselect") {
			alert("Vui lòng chọn phương thức thanh toán!");
			return false;
		}
		return true;
	}
	
	var cookieName = "page_scroll";
	var expdays = 365;

	// An adaptation of Dorcht's cookie functions.

	function setCookie(name, value, expires, path, domain, secure) {
	    if (!expires) expires = new Date();
	    document.cookie = name + "=" + escape(value) + 
	        ((expires == null) ? "" : "; expires=" + expires.toGMTString()) +
	        ((path    == null) ? "" : "; path=" + path) +
	        ((domain  == null) ? "" : "; domain=" + domain) +
	        ((secure  == null) ? "" : "; secure");
	}

	function getCookie(name) {
	    var arg = name + "=";
	    var alen = arg.length;
	    var clen = document.cookie.length;
	    var i = 0;
	    while (i < clen) {
	        var j = i + alen;
	        if (document.cookie.substring(i, j) == arg) {
	            return getCookieVal(j);
	        }
	        i = document.cookie.indexOf(" ", i) + 1;
	        if (i == 0) break;
	    }
	    return null;
	}

	function getCookieVal(offset) {
	    var endstr = document.cookie.indexOf(";", offset);
	    if (endstr == -1) endstr = document.cookie.length;
	    return unescape(document.cookie.substring(offset, endstr));
	}

	function deleteCookie(name, path, domain) {
	    document.cookie = name + "=" +
	        ((path   == null) ? "" : "; path=" + path) +
	        ((domain == null) ? "" : "; domain=" + domain) +
	        "; expires=Thu, 01-Jan-00 00:00:01 GMT";
	}

	function saveScroll() {
	    var expdate = new Date();
	    expdate.setTime(expdate.getTime() + (expdays*24*60*60*1000)); // expiry date

	    var x = document.pageXOffset || document.body.scrollLeft;
	    var y = document.pageYOffset || document.body.scrollTop;
	    var data = x + "_" + y;
	    setCookie(cookieName, data, expdate);
	}

	function loadScroll() {
	    var inf = getCookie(cookieName);
	    if (!inf) { return; }
	    var ar = inf.split("_");
	    if (ar.length == 2) {
	        window.scrollTo(parseInt(ar[0]), parseInt(ar[1]));
	    }
	}
	
</script>

</html>
