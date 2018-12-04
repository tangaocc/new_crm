package cn.tencent.crm.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.tencent.crm.annotation.OwnPermission;
import cn.tencent.crm.domain.CustomerDevPlan;
import cn.tencent.crm.domain.Employee;
import cn.tencent.crm.domain.Permission;
import cn.tencent.crm.domain.PotentialCustomer;
import cn.tencent.crm.domain.CustomerDevPlan;
import cn.tencent.crm.domain.SystemDictionaryItem;
import cn.tencent.crm.query.PermissionQuery;
import cn.tencent.crm.query.CustomerDevPlanQuery;
import cn.tencent.crm.service.ICustomerDevPlanService;
import cn.tencent.crm.service.IEmployeeService;
import cn.tencent.crm.service.IPotentialCustomerService;
import cn.tencent.crm.service.ISystemDictionaryItemService;
import cn.tencent.crm.util.AjaxResult;
import cn.tencent.crm.util.PageList;

@Controller
@RequestMapping("/customerDevPlan")
public class CustomerDevPlanController {
	@Autowired
	private ICustomerDevPlanService customerDevPlanService;
	
	@RequestMapping("/index")
	@OwnPermission("客户开发计划管理")
	public String index() {
		
		return "customerDevPlan/index";
	}
	

	public List<CustomerDevPlan> list(){
		return customerDevPlanService.getAll();
	}	


	@RequestMapping("/list")
	@ResponseBody
	@OwnPermission("客户开发计划列表")
	public PageList<CustomerDevPlan> list(CustomerDevPlanQuery query) {

		return customerDevPlanService.queryPageData(query);// 分页查询

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
	@OwnPermission("客户开发计划删除")
	public AjaxResult delete(Long id) {

		try {
			customerDevPlanService.delete(id);
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
	@OwnPermission("客户开发计划保存")
	public AjaxResult save(CustomerDevPlan customerDevPlan) {
		// 区分是新增还是修改
		try {
			if (customerDevPlan.getId() != null) {
				// 修改
				customerDevPlanService.update(customerDevPlan);
			} else {
				// 新增
				customerDevPlanService.add(customerDevPlan);
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
	
	//查询实施计划
	@Autowired
	private ISystemDictionaryItemService systemDictionaryItemService;
	
	
	@RequestMapping("/querySystemDictionaryItem")
	@ResponseBody
	public List<SystemDictionaryItem> querySystemDictionaryItem(){
		List<SystemDictionaryItem> list = systemDictionaryItemService.getAll();
		return list;
	}
	@Autowired
	private IPotentialCustomerService potentialCustomerService;
	
	
	@RequestMapping("/queryPotentialCustomer")
	@ResponseBody
	public List<PotentialCustomer> queryPotentialCustomer(){
		List<PotentialCustomer> list = potentialCustomerService.getAll();
		return list;
	}
	
	
	
	
	
}
