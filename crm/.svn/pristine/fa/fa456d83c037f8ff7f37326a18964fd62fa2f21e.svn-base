package cn.tencent.crm.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.tencent.crm.domain.Role;
import cn.tencent.crm.query.RoleQuery;
import cn.tencent.crm.service.IRoleService;
import cn.tencent.crm.util.AjaxResult;
import cn.tencent.crm.util.PageList;

@Controller
@RequestMapping("/role")
public class RoleController {
	@Autowired
	private IRoleService roleService;

	
	//跳转主页
	@RequestMapping("/index")
	public String index() {
		
		return "role/index";
		
	}
	
	/**
	 * @param query
	 * @return /employee/loadDataByQuery
	 */
	@RequestMapping("/list")
	@ResponseBody // json格式
	public PageList<Role> list(RoleQuery query) {

		 return roleService.queryPageData(query);
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public AjaxResult delete(Long id) {
		
		try {
			roleService.delete(id);
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
	public AjaxResult save(Role role) {
		//区分是新增还是修改
		try {
			if (role.getId()!=null) {
				//修改
				roleService.update(role);
			}
			else{
				//新增
				roleService.add(role);
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("保存失败，"+e.getMessage());
		}
		
	}
	
	//loadRoleByEmpId
	@RequestMapping("/loadRoleByEmpId")
	@ResponseBody
	public List<Role> loadRoleByEmpId(Long id){
		if (id!=null) {
			List<Role> list = roleService.loadRoleByEmpId(id);
			return list;
		}else{
			return null;
			
		}
		
		
		
	}
	
	
	
	
}
