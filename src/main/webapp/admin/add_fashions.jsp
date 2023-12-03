<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin: Thêm sản phẩm</title>
<%@include file="allCss.jsp"%>
</head>

<style>
:root {
	--arrow-bg: rgba(255, 255, 255, 0.3);
	--option-bg: white;
	--select-bg: rgba(255, 255, 255, 0.2);
}

*:focus {
	outline: none;
	box-shadow: rgb(204, 219, 232) 3px 3px 6px 0px inset,
		rgba(255, 255, 255, 0.5) -3px -3px 6px 1px inset;
}

body {
	background-color: white;
}

label {
	font-size: 18px;
	font-weight: 600;
	color: black !important;
}

input {
	width: 100%;
	height: 35px;
	box-shadow: rgba(50, 50, 93, 0.25) 0px 2px 5px -1px, rgba(0, 0, 0, 0.3)
		0px 1px 3px -1px;
	border: none;
	color: black;
	margin: 10px 0;
	padding: 10px;
	font-size: 18px;
}

input:focus {
	box-shadow: rgba(60, 64, 67, 0.3) 0px 1px 2px 0px,
		rgba(60, 64, 67, 0.15) 0px 1px 3px 1px!immportant;
	border: none !important;
}

select {
	/* Reset Select */
	margin: 10px 0;
	width: 100%;
	box-shadow: rgba(0, 0, 0, 0.1) 0px 1px 3px 0px, rgba(0, 0, 0, 0.06) 0px
		1px 2px 0px;
	border-radius: 0.25em;
	color: white;
	appearance: none;
	border: 0;
	font-size: 18px;
	height: 35px !important;
	/* Personalize */
	flex: 1;
	padding: 0 1em;
	color: black;
	cursor: pointer;
	margin-left: 15px;
}
/* Remove IE arrow */
select::-ms-expand {
	display: none;
}
/* Custom Select wrapper */
.select {
	position: relative;
	display: flex;
	width: 20em;
	border-radius: .25em;
	overflow: hidden;
	align-items: center;
}
/* Arrow */
.select::after {
	content: '\25BC';
	position: absolute;
	top: 0px;
	right: 0;
	padding: 1em;
	height: 30px;
	transition: .25s all ease;
	pointer-events: none;
}
/* Transition */
.select:hover::after {
	color: black;
	opacity: 1;
}

.counter {
	width: 100%;
	display: flex;
	align-items: center;
}

.counter input {
	width: 30%;
	border: 0.5px solid #ccc !important;
	box-shadow: none;
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

input[type=number]::-webkit-inner-spin-button {
	-webkit-appearance: none;
}

.button {
	border: none;
	margin: 10px 0;
	transition: margin-right 0.2s ease;
}

button {
	transition: all 0.3s linear !important;
}

.button:hover {
	background-color: #ccc !important;
	color: black !important;
}
</style>
<body>
	<%@include file="navbar.jsp"%>
	<c:if test="${empty userobj}">
		<c:redirect url="login.jsp" />
	</c:if>
	<div class='dashboard'>
		<div class="dashboard-nav">
			<header>
				<a href="#!" class="menu-toggle"><i class="fas fa-bars"></i></a><a
					href="#" class="brand-logo"><i class="fa-regular fa-heart"></i><span
					class="brand">GROUP 6F</span></a>
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
				<div class="slider">
					<img src="">
				</div>
			</header>
			<div class='dashboard-content'>
				<div class='container'>
					<div class='card'>
						<div class='card-header'>
							<h1>THÊM SẢN PHẨM</h1>
						</div>
						<div class="card-body">
							<c:if test="${not empty succMsg }">
								<p class="text-center text-success"
									style="font-size: 18px; color: #03c03c;">${succMsg }</p>
								<c:remove var="succMsg" scope="session" />
							</c:if>
							<c:if test="${not empty failedMsg }">
								<p class="text-center text-danger"
									style="font-size: 18px; color: #ff2800;">${failedMsg }</p>
								<c:remove var="failedMsg" scope="session" />
							</c:if>
							<form action="../add_fashions" method="post"
								enctype="multipart/form-data">
								<div class="form-group">
									<label for="exampleInputEmail1">Tên sản phẩm</label> <input
										name="fname" type="text" class="form-control"
										id="exampleInputEmail1" aria-describedby="emailHelp">
								</div>

								<div class="form-group">
									<label for="exampleInputEmail1">Size</label> <input name="size"
										type="text" class="form-control" id="exampleInputEmail1"
										aria-describedby="emailHelp">
								</div>


								<div class="counter">
									<label for="exampleInputEmail1" style="margin-bottom: 0;">Số
										lượng*</label><br> <span class="down"
										onClick='decreaseCount(event, this)'>-</span><input
										type="text" value="1" name="quantity" min="1"> <span
										class="up" onClick='increaseCount(event, this)'>+</span>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">Giá nhập (<span
										style="text-decoration: underline; color:">vnđ</span>)
									</label>
									<div class="input-group">
										<input name="pricebuy" type="text" class="form-control"
											id="exampleInputPassword1" aria-describedby="price-addon"
											pattern="[0-9]+([.,][0-9]+)?">
									</div>
								</div>

								<div class="form-group">
									<label for="exampleInputEmail1">Giá bán (<span
										style="text-decoration: underline;">vnđ</span>)
									</label>
									<div class="input-group">
										<input name="price" type="text" class="form-control"
											id="exampleInputPassword1" aria-describedby="price-addon"
											pattern="[0-9]+([.,][0-9]+)?">
									</div>
								</div>


								<div class="select">
									<label for="inputState">Loại</label> <br>
									<select id="inputState" name="categories" class="form-control">
										<option selected
											style="opacity: 0.4 !important; transform: text-uppercase;">Chọn</option>
										<option value="Mới">Mới</option>
									</select>
								</div>

								<div class="select">
									<label for="inputState">Trạng thái</label><br> <select
										id="inputState" name="status" class="form-control">
										<option selected>Chọn</option>
										<option value="Hoạt động">Hoạt động</option>
										<option value="Không hoạt động">Không hoạt động</option>
									</select>
								</div>

								<div class="form-group">
									<label for="exampleFormControlFile1">Ảnh mô tả</label> <input
										name="fimg" type="file" class="form-control-file"
										id="exampleFormControlFile1"
										style="box-shadow: none; font-size: 16px;">
								</div>

								<div class="form-group">
									<label for="exampleTextarea">Mô tả sản phẩm</label><br>
									<textarea name="describe" class="form-control"
										id="exampleTextarea" rows="8" cols="60"></textarea>
								</div>


								<button type="submit" class="button"
									style="width: 40%; padding: 10px; font-size: 20px; background-color: black; color: white; border-radius: 3px;">THÊM</button>

							</form>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


</body>

<script>
	const items = document.querySelectorAll('.nav-ver.nav-link');
	items[3].classList.add('active');
	const text = document.querySelector('.nav-ver.nav-link.active').innerHTML;
	document.getElementById('direction').innerHTML = text;

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
</script>
</html>
