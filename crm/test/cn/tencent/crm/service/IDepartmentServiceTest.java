package cn.tencent.crm.service;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.tencent.crm.domain.Department;
import cn.tencent.crm.query.BaseQuery;
import cn.tencent.crm.query.DepartmentQuery;
import cn.tencent.crm.service.IDepartmentService;
import cn.tencent.crm.util.PageList;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class IDepartmentServiceTest {

	@Autowired
	private IDepartmentService departmentService;
	//测试事务
	@Test
	public void testAdd() {
		List<Department> all = departmentService.getAll();

			for (Department department2 : all) {
				System.out.println(department2);
			}
		//int i = 1/0; 事务加到service上面的放到这儿没用
	}

	@Test
	public void testDelete() {
		departmentService.delete(1L);
	}
	@Test
	public void testUpdate() {
		List<Department> loadDeptTree = departmentService.loadDepartmentTree();
		for (Department department : loadDeptTree) {
			System.out.println(department);
		}
		
	}

	@Test
	public void testGetById() {
		System.out.println(departmentService.loadDepartmentTree());
	}
	@Test
	public void testqueryPageRows() throws Exception {
		DepartmentQuery query = new DepartmentQuery();
		query.setQ("销售");
		query.setState(-1);
		System.out.println(query);
		PageList<Department> queryPageData = departmentService.queryPageData(query);
		List<Department> rows = queryPageData.getRows();
	for (Department department : rows) {
		System.out.println(department);
	}
	System.out.println(rows);
		
	}

}
