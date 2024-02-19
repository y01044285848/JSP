package kr.co.jboard1.db;

public class SQL {

	
	public static final String SELECT_TERMS = "SELECT * FROM `terms`";
	
	public static final String SELECT_COUNT_USER = "SELECT COUNT(*) FROM `user` ";
	public static final String WHERE_UID = "WHERE `uid` = ?";
	public static final String WHERE_NICK = "WHERE `nick` = ?";
	public static final String WHERE_HP = "WHERE `hp` = ?";
	public static final String WHERE_EMAIL = "WHERE `email` = ?";
	
	public static final String INSERT_USER = "INSERT INTO `User` SET "
										   + "`uid`=?, "
										   + "`pass`=SHA2(?, 256), "
										   + "`name`=?, "
										   + "`nick`=?, "
										   + "`email`=?, "
										   + "`hp`=?, "
										   + "`regip`=?, "
										   + "`sms`=?, "
										   + "`rdate`=NOW()";
	
	public static final String SELECT_USER_FOR_LOGIN = "SELECT * FROM `User` WHERE `uid`=? AND `pass`=SHA2(?, 256)";
	
	
	public static final String INSERT_ARTICLE = "INSERT INTO `Article` SET "
												+ "`title`=?, "
												+ "`content`=?, "
												+ "`writer`=?, "
												+ "`regip`=?, "
												+ "`rdate`=NOW()";
	
	public static final String INSERT_COMMENT = "INSERT INTO `Article` SET "
												+ "`parent` = ?, "
												+ "`content` = ?, "
												+ "`writer` = ?, "
												+ "`regip` = ?, "
												+ "`rdate` = NOW()";
	
	public static final String SELECT_COUNT_TOTAL = "SELECT COUNT(*) FROM `Article` AS a "
												+ "JOIN `User` AS b ON a.writer = b.uid "
												+ "WHERE `parent` = 0 ";
	
	public static final String SELECT_ARTICLES = "SELECT a.*,	b.`nick` FROM `Article` AS a "
												+ "JOIN `User` AS b ON a.writer = b.uid "
												+ "WHERE `parent` = 0 ";
	
	public static final String SELECT_ARTICLES_WHERE_TITLE = "AND `title` LIKE ?";											
	public static final String SELECT_ARTICLES_WHERE_CONTENT = "AND `CONTENT` LIKE ?";											
	public static final String SELECT_ARTICLES_WHERE_TITLE_CONTENT = "AND (`title` LIKE ? OR `content` LIKE ?)";											
	public static final String SELECT_ARTICLES_WHERE_WRITER = "AND `nick` LIKE ?";											
	
	public static final String SELECT_ARTICES_ORDER_LIMIT = "ORDER BY `no` DESC LIMIT ?, 10";
	
	public static final String SELECT_COMMENTS = "SELECT a.*, u.`nick` FROM `Article` AS a "
												+ "JOIN `user` AS u ON a.writer = u.uid "
												+ "WHERE `parent` = ? "
												+ "ORDER BY `no` ASC"; 
			//"SELECT * FROM `Article` WHERE `parent` = ?";
	
	
	public static final String SELECT_ARTICLE = "SELECT * FROM `Article` WHERE `no` = ?"; 
	
	public static final String UPDATE_ARTICLE = "UPDATE `Article` SET `title`=?, `content` = ? WHERE `no` = ?";
	
	public static final String UPDATE_HIT_COUNT = "UPDATE `Article` SET `hit` = `hit` + 1 WHERE `no`=?"; 
	
	public static final String UPDATE_ARTICLE_COMMENT_PLUS = "UPDATE `Article` SET `comment` = `comment` + 1 where `no` = ?";
	public static final String UPDATE_ARTICLE_COMMENT_MINUS = "UPDATE `Article` SET `comment` = `comment` - 1 where `no` = ?";
	
	public static final String UPDATE_COMMENT = "UPDATE `Article` SET `content` = ? where `no` = ?";
	
	public static final String DELETE_ARTICLE = "DELETE FROM `Article` WHERE `no`= ? OR `parent` = ?";
	
	public static final String DELETE_COMMENT = "DELETE FROM `Article` WHERE `no`=?";
	
	
}