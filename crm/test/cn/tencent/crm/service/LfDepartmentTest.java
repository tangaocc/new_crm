package cn.tencent.crm.service;

import cn.tencent.crm.domain.Employee;
import cn.tencent.crm.domain.SystemLog;
import cn.tencent.crm.mapper.DepartmentMapper;
import cn.tencent.crm.mapper.EmployeeMapper;
import cn.tencent.crm.mapper.SystemDictionaryItemMapper;
import cn.tencent.crm.mapper.SystemLogMapper;
import cn.tencent.crm.util.MD5Util;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class LfDepartmentTest {

	@Autowired
	private EmployeeMapper employeemapper;

	@Autowired
	private IEmployeeService employeeService;
	@Autowired
	private DepartmentMapper departmentMapper;

	@Autowired
	private SystemDictionaryItemMapper systemdictionary;

	@Autowired
	private ISystemDictionaryItemService systemdictionaryservice;

	@Autowired
	private SystemLogMapper systemlogmapper;

	@Test
	public void testGetId() throws Exception {
		// List<Department> id = departmentMapper.loadAll();
		// Employee id = employeemapper.loadById(1L);
		Employee id = employeeService.getById(1L);
		System.out.println(id);
	}

	@Test
	public void testsystemLog() throws Exception {
		SystemLog system = new SystemLog();
		// system.setOpTime(new Date());
		system.setFunction("权限管理");
		system.setOpIp("1321545");
//		system.setOpUser("");
		system.setParams("sa");
		systemlogmapper.save(system);
	}
	
	@Test
	public void testMima2() throws Exception {
		Employee employee = new Employee();
		employee.setUsername("q");
		employee.setPassword("123");
		
		employeeService.add(employee);
		
		
	}
	
	
	
	@Test
	public void testsystemItem() throws Exception {
//		SystemDictionaryItem t = new SystemDictionaryItem();
//		//SystemDictionaryItem byId = systemdictionaryservice.getById(1L);
//		t.setId(1L);
//		t.setIntro("99");
//		t.setRequence(56L);
//		t.setName(" 大哥");
		// //t.setParent("5");
		// /* systemdictionary.save(t);*/
		//增加
		// systemdictionaryservice.add(t);
		//修改
		//  systemdictionaryservice.update(t);
		/*查询全部
		 * List<SystemDictionaryItem> all = systemdictionaryservice.getAll();
		 * for (SystemDictionaryItem systemDictionaryItem : all) {
		 * System.out.println(systemDictionaryItem); }
		 */
		//System.out.println(T);
		//删除
		//systemdictionaryservice.delete(1L);
		String encrypt = MD5Util.encrypt("123");
		System.out.println(encrypt);
	}
	
	@Test
	public void testMima() throws Exception {
		List<Employee> all = employeeService.getAll();
		for (Employee employee : all) {
			String password = MD5Util.encrypt(employee.getPassword());
			employee.setPassword(password);
			
			employeeService.update(employee);
			
		}
		
	}
	
	
	
	
	
	
}
