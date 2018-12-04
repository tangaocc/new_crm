package cn.tencent.crm.service;

import java.io.InputStream;
import java.util.List;


import cn.tencent.crm.domain.Employee;

/**
 * 继承与IBaseService就拥有基本crud
 * 
 * @author Administrator
 *
 */
public interface IEmployeeService extends IBaseService<Employee> {

	public void add(Employee employee);
	
	//登录
	public Employee login(String username);
//通过RealName找人
	public Employee findByRealName(String sellerRealName);
	
		
	
	
		
}