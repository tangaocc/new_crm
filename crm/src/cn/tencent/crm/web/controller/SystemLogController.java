package cn.tencent.crm.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.tencent.crm.annotation.OwnPermission;
import cn.tencent.crm.domain.SystemDictionaryItem;
import cn.tencent.crm.domain.SystemLog;
import cn.tencent.crm.query.SystemDictionaryItemQuery;
import cn.tencent.crm.query.SystemLogQuery;
import cn.tencent.crm.service.ISystemDictionaryItemService;
import cn.tencent.crm.service.ISystemLogService;
import cn.tencent.crm.util.AjaxResult;
import cn.tencent.crm.util.PageList;

@Controller
@RequestMapping("/systemLog")
public class SystemLogController {
	
	@Autowired
	private ISystemLogService logService;
	
	//跳转主页
	@RequestMapping("/index")
	public String index() {
		return "systemLog/index";
	}
	
 	@RequestMapping("/list")
	@ResponseBody
	public PageList<SystemLog> json(SystemLogQuery basequery){
		return logService.queryPageData(basequery);
	} 
	/*@RequestMapping("/list")
	@ResponseBody
	public List<SystemLog> list(SystemDictionaryItemQuery query){
		return systemlog.getAll();
	}*/
	
	 
	/*
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
	}*/
/*	@ResponseBody
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
	*/
	
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
