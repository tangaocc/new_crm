package cn.tencent.crm.service;

import java.util.List;

import cn.tencent.crm.domain.Department;

/**
 * 继承与IBaseService就拥有基本crud
 * 
 * @author Administrator
 *
 */
public interface IDepartmentService extends IBaseService<Department> {
	//扩展自己方法
	//查询部门树：
	List<Department>  loadDepartmentTree();
}