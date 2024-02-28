package kr.co.jboard2.dao;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.db.DBHelper;
import kr.co.jboard2.db.SQL;
import kr.co.jboard2.dto.FileDTO;

public class FileDAO extends DBHelper {

	private static FileDAO instance = new FileDAO();
	public static FileDAO getInstance() {
		return instance;
	}
	private FileDAO() {}
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public void insertFile(FileDTO fileDTO) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.INSERT_FILE);
			psmt.setInt(1, fileDTO.getAno());
			psmt.setString(2, fileDTO.getoName());
			psmt.setString(3, fileDTO.getsName());
			logger.info("insertFile : " + psmt);
			
			psmt.executeUpdate();
			closeAll();
		}catch (Exception e) {
			logger.error("insertFile : " + e.getMessage());
		}
	} 
	
	public FileDTO selectFile(String fno) {
		
		FileDTO fileDTO = null;
		
		try {
			conn = getConnection();
			conn.setAutoCommit(false);
			
			psmt = conn.prepareStatement(SQL.SELECT_FILE);
			psmt.setString(1, fno);
			logger.info("selectFile : " + psmt);
			
			psmtEtc1 = conn.prepareStatement(SQL.UPDATE_FILE_DOWNLOAD);
			psmtEtc1.setString(1, fno);
			
			rs = psmt.executeQuery();
			psmtEtc1.executeUpdate();
			
			conn.commit();
			if(rs.next()) {
				fileDTO = new FileDTO();
				fileDTO.setFno(rs.getInt(1));
				fileDTO.setAno(rs.getInt(2));
				fileDTO.setoName(rs.getString(3));
				fileDTO.setsName(rs.getString(4));
				fileDTO.setDownload(rs.getInt(5));
				fileDTO.setRdate(rs.getString(6));
			}
			
			closeAll();
		}catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return fileDTO;
	} 
	public List<FileDTO> selectFiles() {
		return null;
	} 
	public void updateFile(FileDTO fileDTO) {
		
	} 
	public void deleteFile(HttpServletRequest req, String ano) {
		
		try {
			conn = getConnection();
			
			psmt = conn.prepareStatement(SQL.SELECT_FILE_BY_ANO);
			psmt.setString(1, ano);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				String fileName = rs.getString(4); //지울 파일명   
				logger.debug(fileName);
				ServletContext ctx = req.getServletContext();
				String deleteFilePath = ctx.getRealPath("/uploads");
				
				deleteFilePath += (File.separator + fileName);
				logger.debug(deleteFilePath);
				File f = new File(deleteFilePath); // 파일 객체생성   
				if( f.exists()) {
					f.delete(); // 파일이 존재하면 파일을 삭제한다.
					logger.debug("Delete File");
				}
			}
			
			psmtEtc1 = conn.prepareStatement(SQL.DELETE_FILE);
			psmtEtc1.setString(1, ano);
			psmtEtc1.executeUpdate();
			
			closeAll();
			
		}catch (Exception e) {
			logger.error(e.getMessage());
		}
		
	}
	
}