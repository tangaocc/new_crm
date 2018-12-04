package cn.tencent.crm.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.tencent.crm.annotation.OwnPermission;
import cn.tencent.crm.domain.Department;
import cn.tencent.crm.domain.Employee;
import cn.tencent.crm.domain.PotentialCustomer;
import cn.tencent.crm.domain.SystemDictionaryItem;
import cn.tencent.crm.query.DepartmentQuery;
import cn.tencent.crm.query.PotentialCustomerQuery;
import cn.tencent.crm.service.IEmployeeService;
import cn.tencent.crm.service.IPotentialCustomerService;
import cn.tencent.crm.service.ISystemDictionaryItemService;
import cn.tencent.crm.util.AjaxResult;
import cn.tencent.crm.util.PageList;

@Controller
@RequestMapping("/potentialCustomer")
public class PotentialCustomerController {
	@Autowired
	private IPotentialCustomerService potentialCustomerService;

	@RequestMapping("/index")
	@OwnPermission("潜在客户管理")
	public String index() {

		return "potentialCustomer/index";
	}

	@RequestMapping("/list")
	@ResponseBody
	public PageList<PotentialCustomer> list(PotentialCustomerQuery query) {

		return potentialCustomerService.queryPageData(query);// 分页查询
	}

	// 删除数据
	/**
	 * 参数：id 返回值： {"success":true,"message":"xxxx"} 原来：response.getWriter()
	 * .print("{\"success\":true,\"message\":\"恭喜你!删除成功\"}");
	 * 现在：springMVC有一个注解@ResponseBody，会把返回对象(AjaxResult(相当于原来ResultHelper))
	 * 使用Jackson框架完成json数据转换 ,而AjaxResult类应该有两个属性（success，message）
	 * 
	 * @param id
	 * @return
	 */

	@RequestMapping("/delete")
	@ResponseBody
	public AjaxResult delete(Long id) {

		try {
			potentialCustomerService.delete(id);
			// 成功
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			// 失败
			return new AjaxResult("删除失败！" + e.getMessage());
		}
	}

	// 保存
	@RequestMapping("/save")
	@ResponseBody
	public AjaxResult save(PotentialCustomer potentialCustomer) {
		// 区分是新增还是修改
		try {
			if (potentialCustomer.getId() != null) {
				// 修改
				potentialCustomerService.update(potentialCustomer);
			} else {
				// 新增
				potentialCustomerService.add(potentialCustomer);
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("保存失败，" + e.getMessage());
		}

	}
	
	//查询创建人
	@Autowired
	private IEmployeeService employeeService;
	
	
	@RequestMapping("/queryEmployee")
	@ResponseBody
	public List<Employee> queryEmployee(){
		List<Employee> list = employeeService.getAll();
		return list;
	}
	
	//查询客户来源
	@Autowired
	private ISystemDictionaryItemService systemDictionaryItemService;
	
	
	@RequestMapping("/querySystemDictionaryItem")
	@ResponseBody
	public List<SystemDictionaryItem> querySystemDictionaryItem(){
		List<SystemDictionaryItem> list = systemDictionaryItemService.getAll();
		return list;
	}
	
	
}
