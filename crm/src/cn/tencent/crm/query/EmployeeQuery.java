package cn.tencent.crm.query;

import java.util.Date;

public class EmployeeQuery extends BaseQuery {
	private int state = -2;
	// 部门id
	private Long deptId;
	private Date beginDate;
	private Date endDate;
	

	@Override
	public String toString() {
		return "EmployeeQuery [state=" + state + ", deptId=" + deptId + ", beginDate=" + beginDate + ", endDate="
				+ endDate + "]";
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public Long getDeptId() {
		return deptId;
	}

	public void setDeptId(Long deptId) {
		this.deptId = deptId;
	}

}
