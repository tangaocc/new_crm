package cn.tencent.crm.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.tencent.crm.annotation.OwnPermission;
import cn.tencent.crm.domain.SystemDictionary;
import cn.tencent.crm.domain.SystemDictionaryItem;
import cn.tencent.crm.query.SystemDictionaryQuery;
import cn.tencent.crm.service.ISystemDictionaryService;
import cn.tencent.crm.util.AjaxResult;
import cn.tencent.crm.util.PageList;

@Controller
@RequestMapping("/systemDictionary")
public class SystemDictionaryController {
	@Autowired
	private ISystemDictionaryService systemDictionaryService;
	
	
	@RequestMapping("/index")
	@OwnPermission("数据字典管理")
	public String index(){
		return "systemDictionary/index";
	}
	
	
	
	@RequestMapping("/list")
	@ResponseBody
	@OwnPermission("数据字典列表")
	public PageList<SystemDictionary> list(SystemDictionaryQuery baseQuery){
		return systemDictionaryService.queryPageData(baseQuery);
	}
	
	@ResponseBody
	@RequestMapping("/delete")
	@OwnPermission("数据字典删除")
	public AjaxResult delete(long id){
		
		System.out.println("进入删除方法");
		
		try {
			systemDictionaryService.delete(id);
			//成功
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			//失败
			return new AjaxResult("删除失败！"+e.getMessage());
		}
	
	}
	//保存数据字典明细
		@RequestMapping("/save")
		@ResponseBody
		@OwnPermission("数据字典保存")
		public AjaxResult save(SystemDictionary t){
			System.out.println("进入保存或修改方法");
			//区分是新增还是修改
					try {
						if (t.getId()!=null) {
							//修改
							systemDictionaryService.update(t);
						}
						else{
							//新增
							systemDictionaryService.add(t);
						}
						return new AjaxResult();
					} catch (Exception e) {
						e.printStackTrace();
						return new AjaxResult("保存失败，"+e.getMessage());
					}
		}
}
