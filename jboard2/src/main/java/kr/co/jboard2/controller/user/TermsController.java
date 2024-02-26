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

import kr.co.jboard2.dto.TermsDTO;
import kr.co.jboard2.service.TermsService;

@WebServlet("/user/terms.do")
public class TermsController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	private TermsService service = TermsService.getInstance();
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void init() throws ServletException {
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 약관 데이터 조회
		TermsDTO termsDTO = service.selectTerms();
		
		req.setAttribute("termsDTO", termsDTO);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/user/terms.jsp");
		dispatcher.forward(req, resp);
		
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String chkSms = req.getParameter("chkSms");
		
		logger.debug("chkSms : " + chkSms);
		
		// 세션 생성
		HttpSession session = req.getSession();
		
		// 세션 처리
		if(chkSms != null) {
			session.setAttribute("sms", "Y");
		}else {
			session.setAttribute("sms", "N");
		}
		
		resp.sendRedirect("/jboard2/user/register.do");
		
	}
}
