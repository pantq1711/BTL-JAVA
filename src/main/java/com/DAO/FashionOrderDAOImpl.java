package com.DAO;

import com.entity.FashionDtls;
import com.entity.Fashion_Order;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

public class FashionOrderDAOImpl implements FashionOrderDAO {

    private Connection conn;

    public FashionOrderDAOImpl(Connection conn) {
        super();
        this.conn = conn;
    }
    
    public boolean updateFashionQuantity(String name, int quantity) {
    	 boolean success = false;

    	    try {
    	        String sql = "UPDATE fashion_dtls SET quantity = quantity - ? WHERE fashionName = ?";
    	        PreparedStatement ps = conn.prepareStatement(sql);
    	        ps.setInt(1, quantity);
    	        ps.setString(2, name);

    	        int rowsAffected = ps.executeUpdate();

    	        if (rowsAffected > 0) {
    	            success = true;
    	        }
    	    } catch (SQLException e) {
    	        e.printStackTrace();
    	    }

    	    return success;
    }

    @Override
    public boolean saveOrder(List<Fashion_Order> orderList) {
        boolean success = false;

        try {
            conn.setAutoCommit(false);

            String sql = "INSERT INTO fashion_order(order_id, user_name, email, address, phno, fashionName, size, price, paymentType, quantity, date) VALUES (?,?,?,?,?,?,?,?,?,?,?);";
            PreparedStatement ps = conn.prepareStatement(sql);

                for (Fashion_Order order : orderList) {
                	
                    ps.setString(1, order.getOrderId());
                    ps.setString(2, order.getUserName());
                    ps.setString(3, order.getEmail());
                    ps.setString(4, order.getFullAdd());
                    ps.setString(5, order.getPhno());
                    ps.setString(6, order.getFashionName());
                    ps.setString(7, order.getSize());
                    ps.setString(8, order.getPrice());
                    ps.setString(9, order.getPaymentType());
                    ps.setInt(10, order.getQuantity());
                    ps.setString(11, order.getDate());

                    ps.addBatch();
                }


                int[] count = ps.executeBatch();
                conn.commit();
                success = true;
                conn.setAutoCommit(true);
            

        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
    }


    @Override
    public List<Fashion_Order> getAllOrder() {
        List<Fashion_Order> list = new ArrayList<>();
        Fashion_Order o = null;

        try {
            String sql = "select * from fashion_order ";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                o = new Fashion_Order();
                o.setId(rs.getInt(1));
                o.setOrderId(rs.getString(2));
                o.setUserName(rs.getString(3));
                o.setEmail(rs.getString(4));
                o.setFullAdd(rs.getString(5));
                o.setPhno(rs.getString(6));
                o.setFashionName(rs.getString(7));
                o.setSize(rs.getString(8));
                o.setPrice(rs.getString(9));
                o.setPaymentType(rs.getString(10));
                o.setQuantity(rs.getInt(11));
                o.setDate(rs.getString(12));
                list.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Fashion_Order> getFashion(String email) {
        List<Fashion_Order> list = new ArrayList<>();
        Fashion_Order o = null;

        try {
            String sql = "select * from fashion_order where email=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                o = new Fashion_Order();
                o.setId(rs.getInt(1));
                o.setOrderId(rs.getString(2));
                o.setUserName(rs.getString(3));
                o.setEmail(rs.getString(4));
                o.setFullAdd(rs.getString(5));
                o.setPhno(rs.getString(6));
                o.setFashionName(rs.getString(7));
                o.setSize(rs.getString(8));
                o.setPrice(rs.getString(9));
                o.setPaymentType(rs.getString(10));
                o.setQuantity(rs.getInt(11));
                o.setDate(rs.getString(12));
                list.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Fashion_Order> getFashion() {
        List<Fashion_Order> list = new ArrayList<>();
        Fashion_Order o = null;

        try {
            String sql = "select * from fashion_order";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                o = new Fashion_Order();
                o.setId(rs.getInt(1));
                o.setOrderId(rs.getString(2));
                o.setUserName(rs.getString(3));
                o.setEmail(rs.getString(4));
                o.setFullAdd(rs.getString(5));
                o.setPhno(rs.getString(6));
                o.setFashionName(rs.getString(7));
                o.setSize(rs.getString(8));
                o.setPrice(rs.getString(9));
                o.setPaymentType(rs.getString(10));
                o.setQuantity(rs.getInt(11));
                o.setDate(rs.getString(12));
                list.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public HashMap<String, String> getTop5FashionOrder(){
    	HashMap <String, String> map = new LinkedHashMap<>();
		try {
			String sql = "SELECT fashionName, SUM(quantity) AS totalQuantity FROM fashion_order GROUP BY fashionName ORDER BY totalQuantity DESC LIMIT 5;";
			PreparedStatement ps = conn.prepareStatement(sql);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if(!map.containsKey(rs.getString(1)))map.put(rs.getString(1), rs.getString(2));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	public HashMap<String, String> getTop5User(){
		ArrayList <String> arr = new ArrayList <>();
		HashMap <String, String> map = new LinkedHashMap<>();
		try {
			String sql = "SELECT fo.user_name, SUM(fd.price * fd.quantity) AS totalValue FROM fashion_order fo JOIN fashion_dtls fd ON fo.fashionName = fd.fashionName GROUP BY fo.user_name ORDER BY totalValue DESC LIMIT 5;";
			PreparedStatement ps = conn.prepareStatement(sql);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if(!map.containsKey(rs.getString(1)))map.put(rs.getString(1), rs.getString(2));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	

	
	public long getDoanhThu()
	{
		long res = 0;
		 List<Fashion_Order> list = new ArrayList<>();
	        Fashion_Order o = null;

	        try {
	            String sql = "select * from fashion_order";
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ResultSet rs = ps.executeQuery();
	            while (rs.next()) {
	                o = new Fashion_Order();
	                o.setId(rs.getInt(1));
	                o.setOrderId(rs.getString(2));
	                o.setUserName(rs.getString(3));
	                o.setEmail(rs.getString(4));
	                o.setFullAdd(rs.getString(5));
	                o.setPhno(rs.getString(6));
	                o.setFashionName(rs.getString(7));
	                o.setSize(rs.getString(8));
	                o.setPrice(rs.getString(9));
	                o.setPaymentType(rs.getString(10));
	                o.setQuantity(rs.getInt(11));
	                o.setDate(rs.getString(12));
	                list.add(o);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }

			
		for(Fashion_Order f : list)
		{
			String priceString = f.getPrice().replaceAll("[^0-9]", ""); // Remove non-numeric characters
		    long price = Long.parseLong(priceString);
		    res += price * f.getQuantity();
            
		}
        return res;
	}
}
