package cn.tencent.crm.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import cn.tencent.crm.annotation.OwnPermission;


import cn.tencent.crm.domain.Customer;

import cn.tencent.crm.domain.CustomerTransfer;
import cn.tencent.crm.domain.Employee;
import cn.tencent.crm.domain.CustomerTransfer;
import cn.tencent.crm.domain.SystemDictionaryItem;
import cn.tencent.crm.query.CustomerTransferQuery;
import cn.tencent.crm.service.ICustomerService;
import cn.tencent.crm.service.ICustomerTransferService;
import cn.tencent.crm.service.IEmployeeService;
import cn.tencent.crm.service.ISystemDictionaryItemService;
import cn.tencent.crm.util.AjaxResult;
import cn.tencent.crm.util.PageList;

@Controller
@RequestMapping("/customerTransfer")
public class CustomerTransferController {
	@Autowired
	private ICustomerTransferService customerTransferService;
	
	@RequestMapping("/index")
	@OwnPermission("客户移交记录管理")
	public String index() {
		
		return "customerTransfer/index";
	}
	

	public List<CustomerTransfer> list(){
		return customerTransferService.getAll();
	}
	
	@RequestMapping("/list")
	@ResponseBody
	@OwnPermission("客户移交记录列表")
	public PageList<CustomerTransfer> list(CustomerTransferQuery query) {

		return customerTransferService.queryPageData(query);// 分页查询
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
	@OwnPermission("客户移交记录删除")
	public AjaxResult delete(Long id) {

		try {
			customerTransferService.delete(id);
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
	@OwnPermission("客户移交记录保存")
	public AjaxResult save(CustomerTransfer customerTransfer) {
		// 区分是新增还是修改
		try {
			if (customerTransfer.getId() != null) {
				// 修改
				customerTransferService.update(customerTransfer);
			} else {
				// 新增
				customerTransferService.add(customerTransfer);
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("保存失败，" + e.getMessage());
		}

	}
	
	//查询新老员工，移交人员
	@Autowired
	private IEmployeeService employeeService;
	
	
	@RequestMapping("/queryEmployee")
	@ResponseBody
	public List<Employee> queryEmployee(){
		List<Employee> list = employeeService.getAll();
		return list;
	}
	
	@Autowired
	private ICustomerService customerService;
	
	@RequestMapping("/queryCustomer")
	@ResponseBody
	public List<Customer> queryCustomer(){
		List<Customer> list = customerService.getAll();
		return list;
		
	}
	
}
