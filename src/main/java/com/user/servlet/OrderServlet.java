package com.user.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.CartDAOImpl;
import com.DAO.FashionOrderDAOImpl;
import com.DB.DBConnect;
import com.entity.Cart;
import com.entity.Fashion_Order;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            if (req.getCharacterEncoding() == null) {
                req.setCharacterEncoding("UTF-8");
            }
            HttpSession session = req.getSession();
            int id = Integer.parseInt(req.getParameter("id"));
            String name = req.getParameter("username");
            String email = req.getParameter("email");
            String phno = req.getParameter("phno");
            String numhouse = req.getParameter("numhouse");
            String address = req.getParameter("address");
            String city = req.getParameter("city");
            String province = req.getParameter("province");
            String paymentType = req.getParameter("paymentType");
            String fullAdd = "Số " + numhouse + "," + address + "," + city + "," + province;
            String date = req.getParameter("timeorder");


                CartDAOImpl cartDAO = new CartDAOImpl(DBConnect.getConn());
                List<Cart> cartList = cartDAO.getFashionByUser(id);

                if (cartList.isEmpty()) {
                    session.setAttribute("failedMsg", "Chưa có sản phẩm được chọn!");
                    resp.sendRedirect("checkout.jsp");
                    return;
                }
                else {

                FashionOrderDAOImpl orderDAO = new FashionOrderDAOImpl(DBConnect.getConn());
                Fashion_Order order = null;
                List<Fashion_Order> orderList = new ArrayList<>();
                Random r = new Random();
                for (Cart cart : cartList) {
                	order = new Fashion_Order();
                    order.setOrderId(String.format("FASHION-ORDER-%03d", r.nextInt(1000)));
                    order.setUserName(name);
                    order.setEmail(email);
                    order.setPhno(phno);
                    order.setFullAdd(fullAdd);
                    order.setFashionName(cart.getFashionName());
                    order.setSize(cart.getSize());
                    order.setPrice(cart.getPrice());
                    order.setPaymentType(paymentType);
                    order.setQuantity(cart.getQuantity());
                    order.setDate(date);
                    cartDAO.deleteFashion(cart.getFid(), id, cart.getCid());
                    orderList.add(order);
                }

                boolean orderSaved = orderDAO.saveOrder(orderList);
                boolean update = orderDAO.updateFashionQuantity(order.getFashionName(), order.getQuantity());
                if (orderSaved && update) {
                    resp.sendRedirect("order_success.jsp");
                } else {
                    session.setAttribute("failedMsg", "Đặt hàng thất bại!");
                    resp.sendRedirect("checkout.jsp");
                }
                }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
