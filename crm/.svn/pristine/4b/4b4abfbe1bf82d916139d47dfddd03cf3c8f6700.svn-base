package cn.tencent.crm.mapper;

import java.util.List;

import cn.tencent.crm.domain.Permission;
import cn.tencent.crm.domain.Role;

public interface PermissionMapper extends BaseMapper<Permission>{

	/**
	 * 根据角色查权限
	 */
	List<Permission> loadPermissionByRole(Role role);
	
	/**
	 * 批量保存权限;加载权限资源;
	 * @param permissionsList
	 */
	void loadPermissionResource(List<Permission> permissionList);
	
	/**
	 * 根据员工id查询权限;
	 * @param id
	 * @return
	 */
	List<Permission> findPermissionByLoginUserId(Long id);
	
	/**
	 * 批量删除
	 */
	void deleteAll();
	
}
