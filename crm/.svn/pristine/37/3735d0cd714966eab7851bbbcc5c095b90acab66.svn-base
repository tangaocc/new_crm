package cn.tencent.crm.web.controller;
import java.io.InputStream;
import java.io.PrintWriter;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import cn.tencent.crm.domain.Department;
import cn.tencent.crm.domain.Employee;
import cn.tencent.crm.domain.SystemLog;
import cn.tencent.crm.query.BaseQuery;
import cn.tencent.crm.query.DepartmentQuery;
import cn.tencent.crm.query.EmployeeQuery;
import cn.tencent.crm.service.IDepartmentService;
import cn.tencent.crm.service.IEmployeeService;
import cn.tencent.crm.util.AjaxResult;
import cn.tencent.crm.util.ExportExcelUtils;
import cn.tencent.crm.util.ImportExcelUtil;
import cn.tencent.crm.util.PageList;
@Controller
@RequestMapping("/excel")
public class ExcelManagerController {

	@Autowired
	private IEmployeeService employeeService;
	@Autowired
	private IDepartmentService departmentService;
	/*@Autowired
	private ISystemLogService logService;*/
	@RequestMapping("/index")
	@ResponseBody
	public String index() {
		
		System.out.println("你好");
		return null;
	}


	/**
	 * 描述：通过传统方式form表单提交方式导入excel文件
	 *
	 * @param request
	 * @throws Exception
	 * 员工上传
	 */
	@RequestMapping(value = "/upload", method = { RequestMethod.GET, RequestMethod.POST })
	public String uploadExcel(MultipartFile file,HttpServletRequest request) throws Exception {
		System.out.println("通过传统方式form表单提交方式导入excel文件！");

		InputStream in = null;
		List<List<Object>> listob = null;
		System.out.println(file);
		if (file==null||file.isEmpty()) {
			throw new Exception("文件不存在,请选择正确文件");
		}
		in = file.getInputStream();
		if (file != null) {
			// 获取文件里面的数据;
			List<String[]> list = employeeService.importExcel(in);
			System.out.println(list);
			// 遍历集合;取出里面的数据;
			for (int i = 0; i < list.size(); i++) {
				Employee employee = new Employee();
				// 取出一行数据;
				String[] strings = list.get(i);
				// 遍历这一行数据
				for (int j = 0; j < strings.length; j++) {
					// 向employee存值;下面是为了让用户名不重复;
					employee.setUsername(strings[2] + UUID.randomUUID().toString().substring(0, 6));
					employee.setPassword(strings[3]);
					// 判断邮箱是否为空;
					
						employee.setRealName(strings[4]);
					
						employee.setTel(strings[5]);
				
					
						employee.setEmail(strings[6]);
					
						employee.setDepartment(null);
						employee.setInputTime(null);
						employee.setState(null);
						employee.setRoles(null);
						
					
				}
				// 把数据持久化到数据库
				employeeService.add(employee);
				// 导入成功+1;
			}
		}
		return "/employee/index";
	}
	/**
	 * 导出
	 * 员工导出
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/export")
	@ResponseBody
	public AjaxResult exportExcel(EmployeeQuery query,HttpServletResponse  response,HttpServletRequest request) {
		try {
			// 查出用户数据
			PageList<Employee> userData = employeeService.queryPageData(query);
			List<Employee> userlist = userData.getRows();
			System.out.println(userlist);
			String title = "员工信息表";
			String[] rowsName = new String[] { "序号","id","员工账号","密码","真实姓名", "电话",
					"邮箱", "部门","录入时间", "状态","角色"};
			List<Object[]> dataList = new ArrayList<Object[]>();
			Object[] objs = null;
			for (int i = 0; i < userlist.size(); i++) {
				Employee po = userlist.get(i);
				objs = new Object[rowsName.length];
				objs[0] = i+1;
				objs[1] = po.getId();
				objs[2] = po.getUsername();
				objs[3] = po.getPassword();
				objs[4] = po.getRealName();
				objs[5] = po.getTel();
				objs[6] = po.getEmail();
				if(po.getDepartment()!=null) {
					objs[7] = po.getDepartment().getName();
				}
				objs[8] = po.getInputTime();
				if(po.getState()!=null&&po.getState()==0) {
					objs[9] ="在职";
				}else {
					objs[9] ="离职";
				}
				
				objs[10] = po.getRoles();
				dataList.add(objs);
			}
			//
			ExportExcelUtils ex = new ExportExcelUtils(title, rowsName, dataList, response,request);
			ex.exportData();

		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("导出失败");
		} 
		return new AjaxResult();
	}
	/*++++++++++++++++++++++++++++++分割线++++++++++++++++++++++++++++++*/
	/**
	 * 描述：通过传统方式form表单提交方式导入excel文件
	 *
	 * @param request
	 * @throws Exception
	 * 部门上传
	 */
	@RequestMapping(value = "/deptUpload", method = { RequestMethod.GET, RequestMethod.POST })
	public String deptUploadExcel(MultipartFile file,HttpServletRequest request) throws Exception {
		System.out.println("通过传统方式form表单提交方式导入excel文件！");

		InputStream in = null;
		List<List<Object>> listob = null;
		System.out.println(file);
		if (file==null||file.isEmpty()) {
			throw new Exception("文件不存在,请选择正确文件");
		}
		in = file.getInputStream();
		if (file != null) {
			// 获取文件里面的数据;
			List<String[]> list = departmentService.importExcel(in);
			System.out.println(list);
			// 遍历集合;取出里面的数据;
			for (int i = 0; i < list.size(); i++) {
				Department department = new Department();
				// 取出一行数据;
				String[] strings = list.get(i);
				// 遍历这一行数据
				for (int j = 0; j < strings.length; j++) {
					// 向employee存值;下面是为了让用户名不重复;
					department.setName(strings[2]);
					department.setSn(strings[3]);
					// 判断邮箱是否为空;
					
					department.setDirPath(strings[4]);
					/*department.setState(strings[7]);*/
					
				/*	department.setTel(strings[5]);
				
					
					department.setEmail(strings[6]);
					
					department.setDepartment(null);
						employee.setInputTime(null);
						employee.setState(null);
						employee.setRoles(null);*/
						
					
				}
				// 把数据持久化到数据库
				departmentService.add(department);
				// 导入成功+1;
			}
		}
		return "/department/index";
	}
	/**
	 * 导出
	 * 员工导出
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/deptExport")
	@ResponseBody
	public AjaxResult deptExport(DepartmentQuery query,HttpServletResponse  response,HttpServletRequest request) {
		try {
			// 查出用户数据
			PageList<Department> deptData = departmentService.queryPageData(query);
			List<Department> deptlist = deptData.getRows();
			System.out.println(deptlist);
			String title = "部门信息表";
			String[] rowsName = new String[] { "序号","id","部门名字","部门标识","部门路径", "部门经理",
					"上级部门", "状态"};
			List<Object[]> dataList = new ArrayList<Object[]>();
			Object[] objs = null;
			for (int i = 0; i < deptlist.size(); i++) {
				Department po = deptlist.get(i);
				objs = new Object[rowsName.length];
				objs[0] = i+1;
				objs[1] = po.getId();
				objs[2] = po.getName();
				objs[4] = po.getDirPath();
				objs[3] = po.getSn();
				if(po.getManager()!=null) {
					objs[5] = po.getManager().getId();
				}
				if(po.getParent()!=null) {
					objs[6] = po.getParent().getName();
				}			
				if(po.getState()!=null&&po.getState()==0) {
					objs[7] ="正常";
				}else {
					objs[7] ="停用";
				}
				dataList.add(objs);
			}
			//
			ExportExcelUtils ex = new ExportExcelUtils(title, rowsName, dataList, response,request);
			ex.exportData();

		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("导出失败");
		} 
		return new AjaxResult();
	}

}
