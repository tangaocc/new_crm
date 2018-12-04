package cn.tencent.crm.service;


import java.util.List;

import cn.tencent.crm.domain.Role;

public interface IRoleService extends IBaseService<Role>{

	public List<Role> loadRoleByEmpId(Long id);

}
