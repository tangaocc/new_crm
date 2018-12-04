package cn.tencent.crm.service.impl;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.tencent.crm.domain.Role;
import cn.tencent.crm.mapper.RoleMapper;
import cn.tencent.crm.service.IRoleService;

@Service
public class RoleServiceImpl extends BaseServiceImpl<Role>
implements IRoleService{
	
	@Autowired
	private RoleMapper roleMapper;
	
	@Override
	public void add(Role role) {
		// 先保存角色表，在保存中间表
		//只有先添加role后，才能获取其ID给中间表
		roleMapper.save(role);
		List<Map<String,Long>> rolePermissions = role.getRolePermissionMap();
		if (rolePermissions!=null && rolePermissions.size()>0) {
			
			roleMapper.saveRolePermission(role.getRolePermissionMap());
		}
		
	}
	
	@Override
	public void update(Role role) {
		//先删除中间表,修改角色表，在保存中间表
		roleMapper.deleteRpByRoleId(role.getId());
		roleMapper.update(role);
		
		List<Map<String, Long>> rolePermissions = role.getRolePermissionMap();
		
		if (rolePermissions!=null && rolePermissions.size()>0 && role.getPermissions().size()>0) {
			roleMapper.saveRolePermission(role.getRolePermissionMap());
		}
		
		
	}
	
	/**
	 * 还需删除关联的中间表
	 */
	@Override
	public void delete(Serializable id) {
		// 删除role表再删中间表
		roleMapper.deleteRpByRoleId(id);
		super.delete(id);
		
	}
	
	
	
	
	/**
	 * 查询员工对应的角色;
	 */
	//@Override
	public List<Role> loadRoleByEmpId(Long id) {
		return roleMapper.getRolesByEmpId(id);
	}
    

}
