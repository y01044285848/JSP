package dao;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import db.DBHelper;

public class MemberDAO extends DBHelper {
	private static MemberDAO instance = new MemberDAO();
	public static MemberDAO getInstance() {
		return instance;
	}
	private MemberDAO() {}
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
	public void insertMember() {}
	public void selectMember() {}
	public void selectMembers() {
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("SELECT * FROM `Member`");
			
			logger.info("psmt : " + psmt);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				
			}
			
			closeAll();
			
		}catch(Exception e) {
			// 로그 출력
			logger.error("selectMembers() : " + e.getMessage());
		}
		
	}
	
	public void updateMember() {}
	public void deleteMember() {}
	
}
