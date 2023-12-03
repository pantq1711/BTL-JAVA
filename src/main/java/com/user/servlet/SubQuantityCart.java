/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.user.servlet;
import com.DB.*;
import com.DAO.*;
import com.entity.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/subcart")
public class SubQuantityCart extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8"); 
        try {
        	HttpSession session = request.getSession();
            User u = (User) session.getAttribute("userobj");
            if (u == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int accountID = u.getId();
            int cid = Integer.parseInt(request.getParameter("cid"));
            int fid = Integer.parseInt(request.getParameter("fid"));
            CartDAOImpl dao = new CartDAOImpl(DBConnect.getConn());
            boolean check = dao.subQuantityToCart(fid, cid);
            if (check) {
            	session.setAttribute("mess", "Giảm số lượng thành công!");
            	response.sendRedirect("checkout.jsp");
            }else {
                session.setAttribute("failed", "Lỗi Server rồi!");
                System.out.print("AGAGAsgd");
            }
        } catch(Exception e)
        {
        	e.printStackTrace();
        }
      
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */

}
