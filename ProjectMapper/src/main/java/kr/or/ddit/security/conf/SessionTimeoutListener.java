package kr.or.ddit.security.conf;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

@WebListener
public class SessionTimeoutListener implements HttpSessionListener {
    @Override
    public void sessionCreated(HttpSessionEvent se) {
        se.getSession().setMaxInactiveInterval(1800); // 세션 Timeout 30분 (초 단위)
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        // 세션 종료 시 로직
    }
}
