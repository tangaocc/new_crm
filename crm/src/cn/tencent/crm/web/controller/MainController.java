package cn.tencent.crm.web.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.tencent.crm.domain.SystemMenu;
import cn.tencent.crm.service.ISystemMenuService;
import cn.tencent.crm.util.UserContext;

@Controller
@RequestMapping("/main")
public class MainController {
	@Autowired
	private ISystemMenuService menuService;
	
	//跳转主页
	@RequestMapping("/index")
	public String index() {
		
		return "main/index";
	}
	/**
	 * 加载菜单;
	 */
	@RequestMapping("/left")
	@ResponseBody
	public List<SystemMenu> left(HttpSession session) {
	  Long loginUserId = UserContext.getUser().getId();
	  return menuService.findMenuByLoginUserId(loginUserId);
	}
}
