package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.entity.Cart;
import com.entity.FashionDtls;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDAOImpl implements CartDAO {

	private Connection conn;

	public CartDAOImpl(Connection conn) {
		this.conn = conn;
	}

	public boolean addCart(Cart c) {
		boolean f = false;
		try {
			String sql = "insert into cart(fid,uid,fashionName,size,price,totalPrice,quantity) values(?,?,?,?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, c.getFid());
			ps.setInt(2, c.getUserId());
			ps.setString(3, c.getFashionName());
			ps.setString(4, c.getSize());
			ps.setString(5, c.getPrice());
			ps.setString(6, c.getTotalPrice());
			ps.setInt(7, c.getQuantity());
			int i = ps.executeUpdate();
			if (i == 1) {
				f = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public List<Cart> getFashionByUser(int userId) {
		List<Cart> list = new ArrayList<>();
		Cart c = null;
		double totalPrice = 0;
		try {
			String sql = "select * from cart where uid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				c = new Cart();
				c.setCid(rs.getInt(1));
				c.setFid(rs.getInt(2));
				c.setUserId(rs.getInt(3));
				c.setFashionName(rs.getString(4));
				c.setSize(rs.getString(5));
				c.setPrice(rs.getString(6));
				totalPrice = totalPrice + Double.parseDouble(rs.getString(7));
				c.setTotalPrice(Double.toString(totalPrice));
				c.setQuantity(rs.getInt("quantity"));
				list.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean deleteFashion(int fid, int uid, int cid) {
		boolean f = false;

		try {
			String sql = "delete from cart where fid=? and uid=? and cid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, fid);
			ps.setInt(2, uid);
			ps.setInt(3, cid);

			int i = ps.executeUpdate();
			if (i == 1) {
				f = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public FashionDtls getFashionByID(int id) {
		FashionDtls b = null;
		try {
			String sql = "select * from fashion_dtls where fashionId=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				b = new FashionDtls();
				b.setFashionId(rs.getInt(1));
				b.setFashionName(rs.getString(2));
				b.setSize(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setFashionCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));
				b.setPriceBuy(rs.getString(9), b.getFashionCategory());
				b.setQuantity(rs.getInt(10));
				b.setDescribe(rs.getString(11));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return b;
	}

	@Override
	public boolean updateQuantityToCart(int quantity, int uid, int fid, int cid) {
	    boolean success = false;
	    try {
	        String sql = "UPDATE Cart SET quantity = ? WHERE uid = ? AND fid = ? AND cid = ?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, quantity);
	        ps.setInt(2, uid);
	        ps.setInt(3, fid);
	        ps.setInt(4, cid);
	        int affectedRows = ps.executeUpdate();
	        success = affectedRows > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return success;
	}

	@Override
	
	public boolean addQuantityToCart(int fid, int cid) {
	    boolean success = false;
	    try {
	        String sql = "UPDATE Cart SET quantity = quantity + 1 WHERE fid = ? AND cid = ?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, fid);
	        ps.setInt(2, cid);
	        int affectedRows = ps.executeUpdate();
	        success = affectedRows > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return success;
	}
	
	@Override
	
	public boolean subQuantityToCart(int fid, int cid) {
	    boolean success = false;
	    try {
	        String sql = "UPDATE Cart SET quantity = quantity - 1 WHERE fid = ? AND cid = ?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, fid);
	        ps.setInt(2, cid);
	        int affectedRows = ps.executeUpdate();
	        success = affectedRows > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return success;
	}
	
}
