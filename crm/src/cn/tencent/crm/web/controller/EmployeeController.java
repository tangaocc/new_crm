package cn.tencent.crm.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.tencent.crm.annotation.OwnPermission;
import cn.tencent.crm.domain.Employee;
import cn.tencent.crm.query.EmployeeQuery;
import cn.tencent.crm.service.IEmployeeService;
import cn.tencent.crm.util.AjaxResult;
import cn.tencent.crm.util.PageList;

@Controller
@RequestMapping("/employee")
public class EmployeeController {

	@Autowired
	private IEmployeeService employeeService;
	//跳转主页
	@RequestMapping("/index")
	@OwnPermission("员工管理")
	public String index() {
		
		return "employee/index";
	}
	//获取列表数据
	@RequestMapping("/list")
	@ResponseBody
	@OwnPermission("员工列表")
	public PageList<Employee> list(EmployeeQuery query) {
		PageList<Employee> pageList = employeeService.queryPageData(query);
		
		return pageList;
	}
	
	//删除数据 
	/**
	 * 参数：id
	 * 返回值： {"success":true,"message":"xxxx"}
	 *    原来：response.getWriter()
	 *        .print("{\"success\":true,\"message\":\"恭喜你!删除成功\"}");
	 *    现在：springMVC有一个注解@ResponseBody，会把返回对象(AjaxResult(相当于原来ResultHelper))使用Jackson框架完成json数据转换
	 *        ,而AjaxResult类应该有两个属性（success，message）
	 * @param id
	 * @return
	 */
	
	@RequestMapping("/delete")
	@ResponseBody
	@OwnPermission("员工删除")
	public AjaxResult delete(Long id) {
		System.out.println("(员工删除)"+id);
		try {
			employeeService.delete(id);
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
	@OwnPermission("员工保存")
	public AjaxResult save(Employee employee) {
		//System.out.println("11111111111111111111111111111111111111111"+employee);
		//区分是新增还是修改
		try {
			if (employee.getId()!=null) {
				//修改
				employeeService.update(employee);
			}
			else{
				//新增
				employeeService.add(employee);
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("保存失败，"+e.getMessage());
		}
		
	}
		

}
