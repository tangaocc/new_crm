package cn.tencent.crm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.tencent.crm.annotation.creat.CreatePermissionUtil;
import cn.tencent.crm.domain.Permission;
import cn.tencent.crm.domain.Role;
import cn.tencent.crm.mapper.PermissionMapper;
import cn.tencent.crm.service.IPermissionService;

@Service
public class PermissionServiceImpl extends BaseServiceImpl<Permission>
implements IPermissionService{
	/**
	 * 根据角色拿到对应权限;
	 */
	@Autowired
	private PermissionMapper permissionMapper;
	
	@Override
	public List<Permission> loadPermissionByRole(Role role) {
		return permissionMapper.loadPermissionByRole(role);
	}
	/**
	 * 注解loadPermissionResource
	 */
	@Override
	public void loadPermissionResource() {
		
		//permissionMapper.deleteAll();//!!!!!!也可以不要，注解工具类有个判定有没有该权限，避免了重复添加!!!!!!!
		
		//从数据库把数据查询出来
		List<Permission> loadAll = permissionMapper.loadAll();
		
		
		//加载类上的注解;获得注解数据集合;把数据库查询出来的数据传入该工具类,返回的是与数据库不同的数据;
		List<Permission> permissionList = CreatePermissionUtil.encapsulationAnnoPermission(loadAll,"cn.tencent.crm.web.controller");
		if(permissionList!=null && permissionList.size()>0){
			permissionMapper.loadPermissionResource(permissionList);
		}
	}
	/**
	 * 根据员工id查询权限;
	 */
	@Override
	public List<Permission> findPermissionByLoginUserId(Long id) {
		
		return permissionMapper.findPermissionByLoginUserId(id);
		 
	}
}
