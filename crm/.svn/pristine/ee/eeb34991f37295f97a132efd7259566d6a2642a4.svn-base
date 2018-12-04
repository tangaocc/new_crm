package cn.tencent.crm.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.tencent.crm.annotation.OwnPermission;
import cn.tencent.crm.domain.SystemDictionaryItem;
import cn.tencent.crm.query.SystemDictionaryItemQuery;
import cn.tencent.crm.service.ISystemDictionaryItemService;
import cn.tencent.crm.util.AjaxResult;
import cn.tencent.crm.util.PageList;

@Controller
@RequestMapping("/systemDictionaryItem")
public class SystemDictionaryItemController {
	
	@Autowired
	private ISystemDictionaryItemService systemdictionaryitemservice;
	
	//跳转主页
	@RequestMapping("/index")
	public String index() {
		return "systemdictionaryitem/index";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public PageList<SystemDictionaryItem> json(SystemDictionaryItemQuery query){
		return systemdictionaryitemservice.queryPageData(query);
	}
	
	 
	
	@RequestMapping("/save")
	@ResponseBody
	public AjaxResult save(SystemDictionaryItem systemDictionaryItem) {
		Long id = systemDictionaryItem.getId();
		try {
			if (id == null) {
				systemdictionaryitemservice.add(systemDictionaryItem);
				System.out.println("打印目录的值"+systemDictionaryItem.getParent());
			} else {
				systemdictionaryitemservice.update(systemDictionaryItem);
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("失败" + e.getMessage());
		}	
	}
	@ResponseBody
	@RequestMapping("/delete")
	public AjaxResult delete(long id){
		
		try {
			systemdictionaryitemservice.delete(id);
			//成功
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			//失败
			return new AjaxResult("删除失败！"+e.getMessage());
		}
		
		
	}
	
	
	/**
	 * @param query
	 * @return /employee/loadDataByQuery
	 */
	/*@RequestMapping("/list")
	@ResponseBody // json格式
	public PageList<Role> list(RoleQuery query) {

		 return service.queryPageData(query);
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public AjaxResult delete(Long id) {
		
		try {
			service.delete(id);
			//成功
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			//失败
			return new AjaxResult("删除失败！"+e.getMessage());
		}
	}*/
 
}
