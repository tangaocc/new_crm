package cn.tencent.crm.service;


import java.util.List;

import cn.tencent.crm.domain.Permission;
import cn.tencent.crm.domain.Role;

public interface IPermissionService extends IBaseService<Permission> {
	/**
	 * 根据角色拿到权限
	 * @param role
	 * @return
	 */
	List<Permission> loadPermissionByRole(Role role);
	
	/**
	 * 批量保存权限;
	 * 加载资源
	 */
	void loadPermissionResource();

	
	/**
	 * 根据用户名拿到权限;
	 */
	List<Permission> findPermissionByLoginUserId(Long id);
}
