package cn.tencent.crm.util;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import cn.tencent.crm.domain.Employee;

/**
 * 封装
 * @author Lenovo
 *
 */

 public class UserContext {

	public static final String LOGIN_USER_IN_SESSION = "loginUser";

	public static void setUser(Employee employee) {

		Subject currentUser = SecurityUtils.getSubject();

		Session session = currentUser.getSession();

		session.setAttribute(LOGIN_USER_IN_SESSION,employee);

	}
	public static Employee getUser(){
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		
		return (Employee) session.getAttribute(LOGIN_USER_IN_SESSION);
	}
} 
