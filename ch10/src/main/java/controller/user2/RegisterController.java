package controller.user2;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User2DTO;
import service.User2Service;

@WebServlet
public class RegisterController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	User2Service service = User2Service.getInstance();
	
	@Override
	public void init() throws ServletException {
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		User2DTO user = new User2DTO();
		
		user.setUid(req.getParameter("uid"));
		user.setName(req.getParameter("name"));
		user.setBirth(req.getParameter("birth"));
		user.setAddr(req.getParameter("addr"));
		
		service.insertUser2(user);
	}
}
