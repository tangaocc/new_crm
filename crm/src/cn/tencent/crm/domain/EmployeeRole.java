package cn.tencent.crm.domain;

public class EmployeeRole {
	Long roleId;
	Long employeeId;
	public EmployeeRole(Long employeeId, Long roleId) {
		this.employeeId = employeeId;
		this.roleId = roleId;
	}
	public Long getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(Long employeeId) {
		this.employeeId = employeeId;
	}
	public Long getRoleId() {
		return roleId;
	}
	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}
	
}
