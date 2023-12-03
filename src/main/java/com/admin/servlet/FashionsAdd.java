
/**
 *
 * @author Anphan
 */
package com.admin.servlet;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.entity.FashionDtls;
import com.DAO.FashionDAOImpl;
import com.DB.*;
import javax.servlet.annotation.MultipartConfig;

@WebServlet("/add_fashions")
@MultipartConfig
public class FashionsAdd extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, FileNotFoundException {
		
	try {
		if(req.getCharacterEncoding() == null) req.setCharacterEncoding("UTF-8");
		String fashionName = req.getParameter("fname"); 
		String price =req.getParameter("price");
		String size= req.getParameter("size");
		String categories= req.getParameter("categories");
		String status= req.getParameter("status");
		Part part= req.getPart("fimg");	
		String fileName= part.getSubmittedFileName();
		String pricebuy = req.getParameter("pricebuy");
		int quantity = Integer.parseInt(req.getParameter("quantity"));
		String describe = req.getParameter("describe");
		FashionDtls b = new FashionDtls(fashionName, size,price, categories, status,fileName,"admin", pricebuy, quantity, describe);
		FashionDAOImpl  dao=  new FashionDAOImpl(DBConnect.getConn()); 
		 boolean f=  dao.addFashions(b);
		 System.out.print(b);
		 HttpSession 	session=req.getSession();
		 if(f) {
			 String path=  getServletContext().getRealPath("")+ "fashion" ;
				
				File file= new File(path);
				part.write(path + File.separator + fileName);
				
		 	session.setAttribute("succMsg","Sản phẩm được thêm thành công!");
			 	resp.sendRedirect("admin/add_fashions.jsp");
		 }else {
			 session.setAttribute("failedMsg", "Lỗi Server rồi!");
			 resp.sendRedirect("admin/add_fashions.jsp");
		 }
		 
	} catch (Exception e) {
		e.printStackTrace();
	}	
		
	
	}
	
}
