package cn.tencent.crm.service;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.tencent.crm.domain.Department;
import cn.tencent.crm.domain.Employee;
import cn.tencent.crm.query.DepartmentQuery;
import cn.tencent.crm.query.EmployeeQuery;
import cn.tencent.crm.util.PageList;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class EmployeeServiceImplTest {
	@Autowired
	private IEmployeeService employeeService;

	@Test
	public void testAdd() {
		Employee employee = new Employee();
		employee.setUsername("1");
		employee.setPassword("1");
		employee.setEmail("oo");
		employeeService.add(employee);
	}

	@Test
	public void testDelete() {
		employeeService.delete(57L);
	}

	@Test
	public void testUpdate() {
		List<Employee> all = employeeService.getAll();
		Employee employee = all.get(1);
		employee.setRealName("顿热子");
		employeeService.update(employee);
	}

	@Test
	public void testGetById() {
		fail("Not yet implemented");
	}

	@Test
	public void testGetAll() {
		List<Employee> all = employeeService.getAll();

		for (Employee employee2 : all) {
			System.out.println(employee2);
		}
	}

	@Test
	public void testQueryPageCount() {
		fail("Not yet implemented");
	}

	@Test
	public void testQueryPageData() {
		EmployeeQuery query = new EmployeeQuery();
		query.setQ("张");
		PageList<Employee> queryPageData = employeeService.queryPageData(query);
		List<Employee> rows = queryPageData.getRows();
	for (Employee employee : rows) {
		System.out.println(employee);
	}
	System.out.println(rows);
	}

}
