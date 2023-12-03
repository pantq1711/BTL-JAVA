package com.DAO;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.entity.FashionDtls;

public class FashionDAOImpl implements FashionDAO {

	private Connection conn;

	public FashionDAOImpl(Connection conn) {
		super();
		this.conn = conn;

	}


	public boolean addFashions(FashionDtls b) {
	    boolean f = false;
	    try {
	        String sql = "insert into fashion_dtls(fashionName, size, price, fashionCategory, status, photoName, email, priceBuy, quantity,des) values(?,?,?,?,?,?,?,?,?,?)";
	        PreparedStatement ps = conn.prepareStatement(sql);

	        ps.setString(1, b.getFashionName());
	        ps.setString(2, b.getSize());
	        ps.setString(3, b.getPrice());
	        ps.setString(4, b.getFashionCategory());
	        ps.setString(5, b.getStatus());
	        ps.setString(6, b.getPhotoName());
	        ps.setString(7, b.getEmail());

	        if ("Cũ".equals(b.getFashionCategory())) {
	            ps.setString(8, "0"); 
	        } else {
	            ps.setString(8, b.getPriceBuy());
	        }

	        ps.setInt(9, b.getQuantity());
	        ps.setString(10, b.getDescribe());
	        int i = ps.executeUpdate();
	        if (i == 1) {
	            f = true;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return f;
	}


	public List<FashionDtls> getAllFashions() {
		List<FashionDtls> list = new ArrayList<FashionDtls>();
		FashionDtls b = null;

		try {
			String sql = "select * from fashion_dtls";
			PreparedStatement ps = conn.prepareStatement(sql);

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
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public FashionDtls getFashionById(int id) {
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

	public boolean updateEditFashions(FashionDtls b) {
		boolean f = false;
		try {
			String sql = "update fashion_dtls set fashionName=?,size=?,price=?,status=?,priceBuy=?,quantity=?,des=? where fashionId=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, b.getFashionName());
			ps.setString(2, b.getSize()); 
			ps.setString(3, b.getPrice());
			ps.setString(4, b.getStatus());
			ps.setString(5, b.getPriceBuy());
			ps.setInt(6, b.getQuantity());
			ps.setInt(7, b.getFashionId());
			ps.setString(8, b.getDescribe());
			int i = ps.executeUpdate();

			if (i == 1) {
				f = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public boolean deleteFashions(int id) {
		boolean f = false;
		try {
			String sql = "delete from fashion_dtls where fashionId=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			int i = ps.executeUpdate();
			if (i == 1) {
				f = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public List<FashionDtls> getNewFashion() {
		List<FashionDtls> list = new ArrayList<FashionDtls>();
		FashionDtls b = null;
		try {
			String sql = "select * from fashion_dtls where fashionCategory=? and status=? order by fashionId DESC";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "Mới");
			ps.setString(2, "Hoạt động");
			ResultSet rs = ps.executeQuery();
			int i = 1;
			while (rs.next() && i <= 4) {
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
				list.add(b);
				i++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<FashionDtls> getRecentFashions() {
		List<FashionDtls> list = new ArrayList<FashionDtls>();
		FashionDtls b = null;
		try {
			String sql = "select * from fashion_dtls where status=? order by fashionId DESC";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "Hoạt động");
			ResultSet rs = ps.executeQuery();
			int i = 1;
			while (rs.next() && i <= 4) {
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
				list.add(b);
				i++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<FashionDtls> getOldFashions() {
		List<FashionDtls> list = new ArrayList<>();
		FashionDtls b = null;
		try {
			String sql = "select * from fashion_dtls where fashionCategory=? and status=? order by fashionId DESC";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "Cũ");
			ps.setString(2, "Hoạt động");
			ResultSet rs = ps.executeQuery();
			int i = 1;
			while (rs.next() && i <= 4) {
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
				list.add(b);
				i++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	public List<FashionDtls> getAllRecentFashion() {
		List<FashionDtls> list = new ArrayList<>();
		FashionDtls b = null;
		try {
			String sql = "select * from fashion_dtls where status=? order by fashionId DESC";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "Hoạt động");
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
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<FashionDtls> getAllNewFashion() {
		List<FashionDtls> list = new ArrayList<>();
		FashionDtls b = null;
		try {
			String sql = "select * from fashion_dtls where fashionCategory=? and status=? order by fashionId DESC";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "Mới");
			ps.setString(2, "Hoạt động");
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
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<FashionDtls> getAllOldFashion() {
		List<FashionDtls> list = new ArrayList<>();
		FashionDtls b = null;
		try {
			String sql = "select * from fashion_dtls where fashionCategory=? and status=? order by fashionId DESC";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "Cũ");
			ps.setString(2, "Hoạt động");
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
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<FashionDtls> getFashionByOld(String email, String cate) {
		List<FashionDtls> list = new ArrayList<>();
		FashionDtls b = null;
		try {
			String sql = "select * from fashion_dtls where fashionCategory=? and email=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, cate);
			ps.setString(2, email);

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
	            b.setPriceBuy("0", "Cũ");
	            b.setQuantity(rs.getInt("quantity"));
	            b.setDescribe(rs.getString(11));
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean oldFashionDelete(String email, String cat, int id) {
		boolean f = false;
		try {
			String sql = "delete from fashion_dtls where fashionCategory=? and email=? and fashionId=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, cat);
			ps.setString(2, email);
			ps.setInt(3, id);

			int i = ps.executeUpdate();
			if (i == 1) {
				f = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public List<FashionDtls> getFashionBySearch(String ch) {
		List<FashionDtls> list = new ArrayList<>();
		FashionDtls b = null;
		try {
			String sql = "select * from fashion_dtls where fashionName like ? or Size like ? or fashionCategory like ? and status=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + ch + "%");
			ps.setString(2, "%" + ch + "%");
			ps.setString(3, "%" + ch + "%");
			ps.setString(4, "Hoạt động");

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
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public List<FashionDtls> getListByPage(ArrayList<FashionDtls> list, int start, int end){
		ArrayList<FashionDtls> arr = new ArrayList<>();
		for(int i=start; i<end; i++) {
			arr.add(list.get(i));
		}
		return arr;
	}
	
	public List<FashionDtls> getSortedFashion(String sortingOption, String category) {
        List<FashionDtls> list = new ArrayList<>();
        FashionDtls b = null;
        if(category.equals("recent"))
        {
            try {
                String sql = "";

                switch (sortingOption) {
                    case "a-z":
                        sql = "SELECT * FROM fashion_dtls ORDER BY fashionName";
                        break;
                    case "z-a":
                        sql = "SELECT * FROM fashion_dtls ORDER BY fashionName DESC";
                        break;
                    case "price-asc":
                        sql = "SELECT * FROM fashion_dtls ORDER BY CAST(price AS DECIMAL)";
                        break;
                    case "price-desc":
                        sql = "SELECT * FROM fashion_dtls ORDER BY CAST(price AS DECIMAL) DESC";
                        break;
                    default:
                        // default sorting (if sortingOption is not recognized)
                        sql = "SELECT * FROM fashion_dtls";
                        break;
                }

                PreparedStatement ps = conn.prepareStatement(sql);
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
                    list.add(b);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        else if(category.equals("new"))
        {
            try {
                String sql = "";
                
                switch (sortingOption) {
                    case "a-z":
                        sql = "SELECT * FROM fashion_dtls where fashionCategory='Mới' ORDER BY fashionName";
                        
                        break;
                    case "z-a":
                        sql = "SELECT * FROM fashion_dtls where fashionCategory='Mới' ORDER BY fashionName DESC";
                        break;
                    case "price-asc":
                        sql = "SELECT * FROM fashion_dtls where fashionCategory='Mới' ORDER BY CAST(price AS DECIMAL)";
                        break;
                    case "price-desc":
                        sql = "SELECT * FROM fashion_dtls where fashionCategory='Mới' ORDER BY CAST(price AS DECIMAL) DESC";
                        break;
                    default:
                        // default sorting (if sortingOption is not recognized)
                        sql = "SELECT * FROM fashion_dtls where fashionCategory='Mới'";
                        break;
                }

                PreparedStatement ps = conn.prepareStatement(sql);
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
                    list.add(b);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        else {
                try {
                    String sql = "";

                    switch (sortingOption) {
                        case "a-z":
                            sql = "SELECT * FROM fashion_dtls where fashionCategory='Cũ' ORDER BY fashionName";
                            break;
                        case "z-a":
                            sql = "SELECT * FROM fashion_dtls where fashionCategory='Cũ' ORDER BY fashionName DESC";
                            break;
                        case "price-asc":
                            sql = "SELECT * FROM fashion_dtls where fashionCategory='Cũ' ORDER BY CAST(price AS DECIMAL)";
                            break;
                        case "price-desc":
                            sql = "SELECT * FROM fashion_dtls where fashionCategory='Cũ' ORDER BY  CAST(price AS DECIMAL) DESC";
                            break;
                        default:
                            // default sorting (if sortingOption is not recognized)
                            sql = "SELECT * FROM fashion_dtls where fashionCategory='Cũ'";
                            break;
                    }

                    PreparedStatement ps = conn.prepareStatement(sql);
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
                        list.add(b);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            }
        }
        return list;
	}
	
	public long getGiaNhap()
	{
		long res = 0;
		List<FashionDtls> list = new ArrayList<FashionDtls>();
		FashionDtls b = null;

		try {
			String sql = "select * from fashion_dtls";
			PreparedStatement ps = conn.prepareStatement(sql);

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
				String priceString = b.getPrice().replaceAll("[^0-9]", ""); // Remove non-numeric characters
			    long price = Long.parseLong(priceString);
			    res += price * b.getQuantity();
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}
     
	public List<FashionDtls> getFashionsExpired() {
		List<FashionDtls> list = new ArrayList<FashionDtls>();
		FashionDtls b = null;

		try {
			String sql = "select * from fashion_dtls where quantity = 0";
			PreparedStatement ps = conn.prepareStatement(sql);

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
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
