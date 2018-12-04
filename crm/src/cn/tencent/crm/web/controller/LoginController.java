package cn.tencent.crm.web.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.ExpiredCredentialsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.tencent.crm.domain.Employee;
import cn.tencent.crm.util.AjaxResult;
import cn.tencent.crm.util.UserContext;

@Controller
@RequestMapping("/login")
public class LoginController {
	
	@RequestMapping("/in")
	@ResponseBody
	public AjaxResult login(String username, String password) {
		System.out.println("进入登录方法1111");
		// 1 获取Subject
		Subject currentUser = SecurityUtils.getSubject();
		// 判断是否登录
		if (!currentUser.isAuthenticated()) {

			try {
				UsernamePasswordToken token = new UsernamePasswordToken(username, password);
				currentUser.login(token);

			} catch (UnknownAccountException e) {
				e.printStackTrace();
				return new AjaxResult("用户名或密码不正确!" + e.getMessage());
			} catch (IncorrectCredentialsException e) {
				e.printStackTrace();
				return new AjaxResult("用户名或密码不正确!" + e.getMessage());
			} catch (LockedAccountException e) {
				e.printStackTrace();
				return new AjaxResult("账号被锁定!" + e.getMessage());
			} catch (ExpiredCredentialsException e) {
				e.printStackTrace();
				return new AjaxResult("密码已经过期" + e.getMessage());
			} catch (AuthenticationException e) {
				e.printStackTrace();
				return new AjaxResult("系统错误!" + e.getMessage());

			}
		}
		
		//登陆成功后，把登陆信息放入session中，以便于其他地方获取
		Employee loginUser =(Employee)currentUser.getPrincipal();
		System.out.println(loginUser);
		
		UserContext.setUser(loginUser);

		return new AjaxResult();
	}
}
