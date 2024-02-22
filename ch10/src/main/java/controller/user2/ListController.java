package controller.user2;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User2DTO;
import service.User2Service;

@WebServlet("/user2/list.do")
public class ListController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	User2Service service = User2Service.getInstance();
	
	@Override
	public void init() throws ServletException {
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		List<User2DTO> users = service.selectUser2s();
		req.setAttribute("users", users);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/user2/list.jsp");
		dispatcher.forward(req, resp);
		
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
	
}
