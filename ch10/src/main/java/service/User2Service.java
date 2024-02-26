package service;

import java.util.List;

import dao.User2DAO;
import dto.User2DTO;

public class User2Service {
	
	private static User2Service instance = new User2Service();
	
	User2DAO dao = User2DAO.getInstance();
	
	public static User2Service getInstance() {
		return instance;
	}
	
	private User2Service() {}
	
	public List<User2DTO> selectUser2s(){
		return dao.selectUser2s();
	}
	
	public void insertUser2(User2DTO user) {
		dao.insertUser2(user);
	}
	
	public void deleteUser2(String uid) {
		dao.deleteUser2(uid);
	}
	
	public User2DTO selectUser2(String uid) {
		return dao.selectUser2(uid);
	}
	
	public void updateUser2(User2DTO user) {
		dao.updateUser2(user);
	}
}
