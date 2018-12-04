package cn.tencent.crm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.tencent.crm.domain.Department;
import cn.tencent.crm.mapper.DepartmentMapper;
import cn.tencent.crm.service.IDepartmentService;

@Service
public class DepartmentServiceImpl extends BaseServiceImpl<Department> 
	implements IDepartmentService {

	
	@Autowired
	private DepartmentMapper departmentmapper;
	//查询部门树
	@Override
	public List<Department> loadDepartmentTree() {
		return departmentmapper.loadDepartmentTree();
		
	}
	
	
}
