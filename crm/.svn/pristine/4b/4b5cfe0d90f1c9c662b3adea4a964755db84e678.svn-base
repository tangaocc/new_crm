package cn.tencent.crm.web.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.tencent.crm.annotation.OwnPermission;
import cn.tencent.crm.domain.SystemMenu;
import cn.tencent.crm.query.SystemMenuQuery;
import cn.tencent.crm.service.ISystemMenuService;
import cn.tencent.crm.util.AjaxResult;
import cn.tencent.crm.util.PageList;
import cn.tencent.crm.util.UserContext;



@Controller
@RequestMapping("/systemMenu")
public class SystemMenuController {

	@Autowired
	private ISystemMenuService systemMenuService;

	@RequestMapping("/index")
	@OwnPermission("系统菜单管理")
	public String index() {
		return "systemMenu/index";
	}

	@RequestMapping("/getselect")
	@ResponseBody
	public List<SystemMenu> selectList() {
		System.out.println("----------------");
		return systemMenuService.getAll();
	}

	@RequestMapping("/list")
	@ResponseBody
	@OwnPermission("系统菜单列表")
	public PageList<SystemMenu> list(SystemMenuQuery query) {
		PageList<SystemMenu> pageList = systemMenuService.queryPageData(query);
		return pageList;
	}
	@RequestMapping("/findMenuByLoginUserId")
	@ResponseBody
	@OwnPermission("系统菜单树")
	public List<SystemMenu> findMenuByLoginUserId(Long loginUserId) {
		List<SystemMenu> list = systemMenuService.findMenuByLoginUserId(loginUserId);
		return list;
	}
	/**
	 * 加载菜单;
	 */
	@RequestMapping("/left")
	@ResponseBody
	public List<SystemMenu> left(HttpSession session) {
	  Long loginUserId = UserContext.getUser().getId();
	  return systemMenuService.findMenuByLoginUserId(loginUserId);
	}
	
	
	@RequestMapping("/save")
	@ResponseBody
	@OwnPermission("系统菜单保存")
	public AjaxResult save(SystemMenu systemMenu) {
		Long id = systemMenu.getId();
		try {
			if (id == null) {
				systemMenuService.add(systemMenu);
			} else {
				systemMenuService.update(systemMenu);
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("失败" + e.getMessage());
		}
	}

	@RequestMapping("/del")
	@ResponseBody
	@OwnPermission("系统菜单删除")
	public AjaxResult del(Long id) {
		try {
			systemMenuService.delete(id);
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("删除失败" + e.getMessage());
		}
	}

}
