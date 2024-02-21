package sub3;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

// 컨테이너(WAS)의 실행/종료를 감시하는 리스너
public class MyContextListener implements ServletContextListener{
	public MyContextListener() {
		System.out.println("MyContextListener()...");
	}
	
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		System.out.println("ContextInitialized()...");
	}
	
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		System.out.println("ContextDestroyed()...");
	}
	
	
}
