package cn.tencent.crm.mapper;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import cn.tencent.crm.domain.Role;



public interface RoleMapper extends BaseMapper<Role> {

	/**
	 * 根据roleId删除中间表
	 * @param roleId
	 */
	void deleteRpByRoleId(Serializable roleId);

	/**
	 * 保存中间表
	 * @param list
	 */
	//void addRp(List<RolePermision> list);
	void saveRolePermission(List<Map<String,Long>> list);
	//void saveRolePermission(List<Map<String,Long>> list);
	//定义集合装role的id和permission的id;
	//void saveRolePermission(List<RolePermission> rolePermission);
	
	/**
	 * 根据员工id查角色
	 * @param eid
	 * @return
	 */
	List<Role> getRolesByEmpId(Long id);
	
}
