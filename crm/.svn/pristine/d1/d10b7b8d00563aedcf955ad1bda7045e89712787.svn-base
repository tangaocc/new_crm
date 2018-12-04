package cn.tencent.crm.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.tencent.crm.annotation.OwnPermission;
import cn.tencent.crm.domain.Permission;
import cn.tencent.crm.domain.Role;
import cn.tencent.crm.domain.SystemMenu;
import cn.tencent.crm.query.PermissionQuery;
import cn.tencent.crm.service.IPermissionService;
import cn.tencent.crm.service.ISystemMenuService;
import cn.tencent.crm.util.AjaxResult;
import cn.tencent.crm.util.PageList;

@Controller
@RequestMapping("/permission")
public class PermissionController {
	@Autowired
	private IPermissionService permissionservice;
	@Autowired
	private ISystemMenuService menuService; 
	
	//跳转主页
	@RequestMapping("/index")
	@OwnPermission("权限管理")
	public String index() {
		
		return "permission/index";
		
	}
	
	/**
	 * @param query
	 * @return /employee/loadDataByQuery
	 */
	@RequestMapping("/list")
	@ResponseBody // json格式
	@OwnPermission("权限列表")
	public PageList<Permission> list(PermissionQuery query) {

		 return permissionservice.queryPageData(query);
	}
	@RequestMapping("/queryAll")
	@ResponseBody // json格式
	public List<Permission> queryAll() {
		return permissionservice.getAll();
	}
	
	
	@RequestMapping("/delete")
	@ResponseBody
	@OwnPermission("权限删除")
	public AjaxResult delete(Long id) {
		
		try {
			permissionservice.delete(id);
			//成功
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			//失败
			return new AjaxResult("删除失败！"+e.getMessage());
		}
	}
	
	//保存
	@RequestMapping("/save")
	@ResponseBody
	@OwnPermission("权限保存")
	public AjaxResult save(Permission permission) {
		//区分是新增还是修改
		try {
			if (permission.getId()!=null) {
				//修改
				permissionservice.update(permission);
			}
			else{
				//新增
				permissionservice.add(permission);
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("保存失败，"+e.getMessage());
		}
		
	}
	
	/**
	 * 加载所有菜单
	 * @param permission
	 * @return
	 */
	@RequestMapping("/getAllMenu")
	@ResponseBody
	public List<SystemMenu> getAllMenu() {
		
		return menuService.getAll();
	}
	
	/**这里是预备用的关于动态权限菜单的代码
	 * 根据角色加载对应的权限
	 */
	@RequestMapping("/loadPermissionByRole")
	@ResponseBody
	public List<Permission> loadPermissionByRole(Role role) {
		if(role!=null){
			
			return permissionservice.loadPermissionByRole(role);
		}
		
		return null;
	}
	
	/**批量添加权限
	 * 加载资源的方法;loadPermissionResource
	 * @return
	 */
	@RequestMapping("/loadResource")
	@ResponseBody
	public AjaxResult createPermission() {
		//调用加载资源的方法;
		try {
			permissionservice.loadPermissionResource();
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("操作失败!");
		}
	}
	
}
