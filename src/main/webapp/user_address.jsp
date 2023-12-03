<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Chỉnh sửa Address</title>
<link rel="stylesheet" href="all_component/userPageStyle.css">
<%@include file="all_component/allCss.jsp"%>

<style>
.footer-block{
	margin-top:25%!important;
}
</style>
</head>
<body style="background-color: #f0f1f2;">
	<%@include file="all_component/navbar.jsp"%>

	<div class="user-content-main">
		<%@include file="all_component/nav-user-page.jsp"%>
		<div class="user-content">

			<c:if test="${not empty failedMsg }">
				<h5 class="text-center text-danger">${failedMsg}</h5>
				<c:remove var="failedMsg" scope="session" />
			</c:if>
			<c:if test="${not empty succMsg }">
				<h5 class="text-center text-success">${succMsg}</h5>
				<c:remove var="succMsg" scope="session" />
			</c:if>
			<form action="update_address" method="post">
				<input class="info" type="hidden" value="${userobj.id}" name="id">


				<div class="form-group">
					<label for="inputPassword4">Địa chỉ *</label> <input type="text"
						name="address" class="info form-control" id="inputPassword4">
				</div>
				<div class="form-group">
					<label for="inputEmail4">Landmark*</label> <input type="number"
						name="landmark" class="info form-control" id="inputEmail4">
				</div>


				<div class="form-group">
					<label for="inputPassword4">City*</label> <input type="text"
						name="city" class="info form-control" id="inputPassword4">
				</div>


				<div class="form-group">
					<label for="inputPassword4">State</label> <input type="text"
						name="state" class="info form-control" id="inputPassword4">
				</div>


				<div class="form-group">
					<label for="inputPassword4">Pincode(No problem)</label> <input
						type="number" name="pincode" class="info form-control"
						id="inputPassword4">
				</div>

				<div class="form-group">
					<label for="exampleInputPassword1">Confirm Password*</label> <input
						type="password" class="confirm info form-control"
						id="exampleInputPassword1" required="required" name="password">
				</div>



				<div class="text-center">
					<button class="btn-update">add address</button>

				</div>


			</form>

		</div>

	</div>

	<%@include file="all_component/footer.jsp"%>
</body>
<script>
	const items = document.querySelectorAll('.nav-ver.nav-link') ;
	items[2].classList.add('active');
	const text = document.querySelector('.nav-ver.nav-link.active').innerHTML;
	document.getElementById('direction').innerHTML = text;
</script>

</html>
