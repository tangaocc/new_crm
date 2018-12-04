package cn.tencent.crm.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.tencent.crm.annotation.OwnPermission;
import cn.tencent.crm.domain.Department;
import cn.tencent.crm.query.DepartmentQuery;
import cn.tencent.crm.service.IDepartmentService;
import cn.tencent.crm.util.AjaxResult;
import cn.tencent.crm.util.PageList;

@Controller
@RequestMapping("/department")
public class DepartmentController {

	@Autowired
	private IDepartmentService departmentService;
	//跳转主页
	@RequestMapping("/index")
	@OwnPermission("部门管理")
	public String index() {
		
		return "department/index";
	}
	//获取列表数据
	@RequestMapping("/list")
	@ResponseBody
	@OwnPermission("部门列表")
	public PageList<Department> list(DepartmentQuery query) {
		
		//return departmentService.getAll();
		return departmentService.queryPageData(query);//分页查询
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
	@OwnPermission("部门删除")
	public AjaxResult delete(Long id) {
		
		try {
			departmentService.delete(id);
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
	@OwnPermission("部门保存")
	public AjaxResult save(Department department) {
		//区分是新增还是修改
		try {
			if (department.getId()!=null) {
				//修改
				departmentService.update(department);
			}
			else{
				//新增
				departmentService.add(department);
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("保存失败，"+e.getMessage());
		}
		
	}
	
	/**
	 * 查询部门树
	 * loadDepartmentTree
	 * @param id
	 * @return
	 */
	@RequestMapping("/loadDepartmentTree")
	@ResponseBody
	public List<Department> loadDepartmentTree(Long id){
		return departmentService.loadDepartmentTree();
	
	
	
	}
		
}
