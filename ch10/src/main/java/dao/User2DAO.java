package dao;

import java.util.ArrayList;
import java.util.List;

import db.DBHelper;
import dto.User2DTO;

public class User2DAO extends DBHelper{
	
	private static User2DAO instance = new User2DAO();
	
	public static User2DAO getInstance() {
		return instance;
	}
	
	private User2DAO() {}
	
	public List<User2DTO> selectUser2s(){
		List<User2DTO> users = new ArrayList<>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT * FROM `User2`");
			
			while(rs.next()) {
				User2DTO user = new User2DTO();
				user.setUid(rs.getString(1));
				user.setName(rs.getString(2));
				user.setBirth(rs.getString(3));
				user.setAddr(rs.getString(4));
				
				users.add(user);
			}
			closeAll();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return users;
	}
	
	public void insertUser2(User2DTO user) {
		
	}
}
