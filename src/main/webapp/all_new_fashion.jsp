<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ page import="com.entity.*"%>
<%@ page import="java.util.List"%>
<%@ page import="com.DB.DBConnect"%>
<%@ page import="com.DAO.FashionDAOImpl"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>All Recent Fashion</title>
<%@ include file="all_component/allCss.jsp"%>
<style type="text/css">
.img-thumblin {
	width: 100%;
	height: auto;
	max-width: 100px;
	max-height: 100px;
	display: block;
	margin: 0 auto;
}

#toast {
	min-width: 300px;
	position: fixed;
	bottom: 30px;
	left: 50%;
	margin-left: -125px;
	padding: 10px;
	color: white;
	text-align: center;
	z-index: 1;
	font-size: 18px;
	visibility: hidden;
	box-shadow: 0px 0px 100px #000;
}

#toast.display {
	visibility: visible;
	animation: fadeIn 0.5s, fadeOut 0.5s 2.5s;
}

@
keyframes fadeIn {from { bottom:0;
	opacity: 0;
}

to {
	bottom: 30px;
	opacity: 1;
}

}
@
keyframes fadeOut {from { bottom:30px;
	opacity: 1;
}

to {
	bottom: 0;
	opacity: 0;
}



}

/* Add style for success toast */
#toast.success {
	background-color: #dc3545; /* Red color */
}

#sortingOptions{
	margin:20px;
	width:200px;
	height:38px;
	padding:8px;
	border-radius:5px;
}

#sortingOptions:focus{
	border:0.5px solid #ccc;
}

.sort{
	font-size:20px; margin:0 10px;
}

</style>

<%@include file="all_component/allCss.jsp"%>
</head>
<body>

	
	<%
    User u = (User) session.getAttribute("userobj");
    %>
	<c:if test="${not empty addCart}">
		<!-- Add "success" class for success toast -->
		<div id="toast" class="success">${addCart}</div>

		<script type="text/javascript">
            showToast();
            function showToast() {
                $('#toast').addClass("display");
                setTimeout(() => {
                    $("#toast").removeClass("display");
                }, 2000);
            }
        </script>

		<c:remove var="addCart" scope="session" />
	</c:if>
	<%@include file="all_component/navbar.jsp"%>
	<div class="container-fluid">
		<form id="sortingForm" action="" method="get">
            <label class="sort" for="sortingOptions" style="font-size:20px; margin:0 10px;">Sắp xếp:</label>
            <!-- Dropdown for sorting options -->
            <select id="sortingOptions" name="sortingOption" onchange="this.form.submit()">
                <option value="a-z">A-Z</option>
                <option value="z-a">Z-A</option>
                <option value="price-asc">Giá tăng dần</option>
                <option value="price-desc">Giá giảm dần</option>
            </select>
        </form>
		<div class="row p-3">
			<%
            // Create a FashionDAOImpl instance with a database connection
            FashionDAOImpl dao3 = new FashionDAOImpl(DBConnect.getConn());
            // Retrieve the sorting option from the request parameters
            String sortingOption = request.getParameter("sortingOption");
            // Set a default sorting option if null
            if (sortingOption == null) {
                sortingOption = "a-z"; // Default sorting option
            }
            // Retrieve the list of sorted fashion items based on the sorting option
            List<FashionDtls> list3 = dao3.getSortedFashion(sortingOption, "new");
            // Iterate over the list and display fashion items
            for (FashionDtls b : list3) {
            %>
			<div class="items col-md-2"
				style="padding: 0; margin: 0 5px; max-height: fit-content !important;">
				<div class="cart-user" style="padding: 0; width: 100%;">
					<div class="card-body" style="padding: 0; width: 100%;">
						<img alt="" src="fashion/<%=b.getPhotoName()%>"
							style="width: 100%; height: 100;">
						<div class="inf-product" style="padding: 10px;">
							<p class="name"><%=b.getFashionName()%></p>
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
										style="background-color: rgba(0, 0, 0, 0.7); border: none;"></i></a>
								</div>
								<%
								} else {
								%>
								<div class="cart-icon">
									<a href="cart?fid=<%=b.getFashionId()%>&&uid=<%=u.getId()%>"
										class="cart-link btn btn-danger btn-sm ml-2"
										style="background-color: rgba(0, 0, 0, 0.7); border: none;"><i
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
	</div>
</body>

<script>
const $ = document.querySelector.bind(document);
const $$ = document.querySelectorAll.bind(document) ;
const tabs = $$('.nav-h.nav-item');
$('.nav-h.nav-item.active').classList.remove('active') ;
tabs[2].classList.add('active');
</script>
</html>
