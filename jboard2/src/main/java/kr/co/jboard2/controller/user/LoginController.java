package kr.co.jboard2.controller.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.dto.UserDTO;
import kr.co.jboard2.service.UserService;

@WebServlet("/user/login.do")
public class LoginController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private UserService service = UserService.getInstance();
	
	@Override
	public void init() throws ServletException {
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/user/login.jsp");
		dispatcher.forward(req, resp);
		
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String uid = req.getParameter("uid");
		String pass = req.getParameter("pass");
		
		logger.debug(uid);
		UserDTO userDTO = service.selectUserForLogin(uid, pass);
		if(userDTO != null) {
			logger.debug(userDTO.toString());
			//request session / httpsession 차이 확인
			//req.getSession().setAttribute("sessUser", userDTO);
			
			HttpSession session = req.getSession();
			session.setAttribute("sessUser", userDTO);

			resp.sendRedirect("/jboard2/list.do");
			
		}else {
			resp.sendRedirect("/jboard2/user/login.do?code=100");
			
		}
		
	}
	
	
}
