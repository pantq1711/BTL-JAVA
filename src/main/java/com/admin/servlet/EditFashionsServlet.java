
/**
 *
 * @author Anphan
 */
package com.admin.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.FashionDAOImpl;
import com.DB.DBConnect;
import com.entity.FashionDtls;

@WebServlet("/editFashions")
public class EditFashionsServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			if(req.getCharacterEncoding() == null) req.setCharacterEncoding("UTF-8");
			int id = Integer.parseInt(req.getParameter("id"));
			String fashionName = req.getParameter("fname");
			String price = req.getParameter("price");
			String size = req.getParameter("size");
			String status = req.getParameter("status");
			int quantity = Integer.parseInt(req.getParameter("quantity"));
			String describe = req.getParameter("describe");
			FashionDtls b = new FashionDtls();
			b.setFashionId(id);
			b.setFashionName(fashionName);
			b.setSize(size);
			b.setPrice(price);
			b.setStatus(status);
			b.setQuantity(quantity);
			b.setDescribe(describe);
			FashionDAOImpl dao = new FashionDAOImpl(DBConnect.getConn());
			boolean f = dao.updateEditFashions(b);

			HttpSession session = req.getSession();
			if (f) {
				session.setAttribute("succMsg", "Sản phẩm được cập nhật thành công!");
				resp.sendRedirect("admin/all_fashions.jsp");
			} else {
				session.setAttribute("failedMsg", "Lỗi Server rồi !!!");
				resp.sendRedirect("admin/all_fashions.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
