package cn.tencent.crm.mapper;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import cn.tencent.crm.domain.Employee;
import cn.tencent.crm.domain.EmployeeRole;

public interface EmployeeMapper extends BaseMapper<Employee> {

	//登录方法
	public Employee loadByUsername(String username);
	
	
	/**
	 * 保存中间表
	 * @param empRoles
	 */
	void saveEmployeeRole(List<EmployeeRole> empRoles);
	//void saveEmployeeRole(List<Map<String,Long>> list);
	
	//removeEmployeeRole
	/**
	 * 根据员工角色删除中间表;
	 * @param id
	 */
	void removeEmployeeRole(Serializable id);


	public Employee findByRealName(String sellerRealName);
	
	
	
}
