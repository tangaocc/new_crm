package cn.tencent.crm.service;

import cn.tencent.crm.annotation.creat.CreatePermissionUtil;
import cn.tencent.crm.domain.Permission;
import cn.tencent.crm.domain.Role;
import cn.tencent.crm.mapper.PermissionMapper;
import cn.tencent.crm.mapper.RoleMapper;
import cn.tencent.crm.query.RoleQuery;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

import static org.junit.Assert.fail;

//import org.apache.jasper.tagplugins.jstl.core.ForEach;

public class IRoleServiceTest extends BaseTest{

	@Autowired
	private RoleMapper roleMapper;
	@Autowired
	private IRoleService roleService;
	@Autowired
	private PermissionMapper permissionMapper;
	@Autowired
	private IPermissionService permissionService;
	@Test
	public void testAdd() {
		fail("Not yet implemented");
	}

	@Test
	public void testDelete() {
		fail("Not yet implemented");
	}

	@Test
	public void testUpdate() {
		fail("Not yet implemented");
	}

	@Test
	public void testGetById() {
		fail("Not yet implemented");
	}

	@Test
	public void testGetAll() {
		fail("Not yet implemented");
	}

	@Test
	public void testQueryPageData() {
		RoleQuery query = new RoleQuery();
		List<Role> list = roleMapper.queryPageData(query);
		for (Role role : list) {
			System.out.println(role);
			System.out.println(role.getPermissions());
		}
	}
	
	
	@Test
	public void testSavePermission() throws Exception {
		List<Permission> loadAll = permissionMapper.loadAll();
		List<Permission> permission = CreatePermissionUtil.encapsulationAnnoPermission(loadAll,"cn.tencent.crm.web.controller");
		for (Permission permission2 : permission) {
			System.out.println("自己控制权限---------------:"+permission2);
		}
		if(permission!=null && permission.size()>0){
			permissionService.loadPermissionResource();
		}
	}
	
	
	@Test
	public void testloadRoleByEmpId() throws Exception {
	
		List<Role> list = roleService.loadRoleByEmpId(1L);
		System.out.println(list);
		
	}
	
	
	
	

}
