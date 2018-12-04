package cn.tencent.crm.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Role implements Serializable{
	private Long id;
	private String sn;// 角色编号 admin等等
	private String name;// 角色名称 超级管理员等等
	// 角色和权限 多对多关系
	private List<Permission> permissions = new ArrayList<Permission>();

	
	public List<Map<String, Long>> getRolePermissionMap() {
	    List<Map<String, Long>> list = new ArrayList<>();
	    if (getPermissions().size() != 0) {
	      for (Permission permission : getPermissions()) {
			Map<String, Long> map = new HashMap<String, Long>();
			map.put("roleId", id);
			map.put("permissionId", permission.getId());
			list.add(map);
	      }
	    }
	    return list;
	  }

	
	/**方案1用中间表
	 * 在role的domain中提供一个获取这个role的所有的中间表的信息
	 * @return
	 */
	public List<RolePermission> getPerms(){
		List<RolePermission> list =new ArrayList<>();
		//遍历这个角色的所有权限：
		for (Permission permission : permissions) {
			//这个角色拥有权限：
			RolePermission rp = new RolePermission();
			rp.setRoleId(this.id);//当前role的id
			rp.setPermissionId(permission.getId());
			list.add(rp);
		}
//		//map:key：roleId  value:role的id
//		//map:key：permId  value:权限的id
//		List<Map<String,Long>> list =new ArrayList<>();
//		//遍历这个角色的所有权限：
//		for (Permission permission : permissions) {
//			//这个角色拥有权限：
//			Map<String,Long> map = new HashMap<>();
//			map.put("roleId", this.id);
//			map.put("permId", permission.getId());
//			list.add(map);
//		}
		
		return list;
	}
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getSn() {
		return sn;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Permission> getPermissions() {
		return permissions;
	}

	public void setPermissions(List<Permission> permissions) {
		this.permissions = permissions;
	}


	@Override
	public String toString() {
		return "Role [id=" + id + ", sn=" + sn + ", name=" + name + "]";
	}


	
	
}
