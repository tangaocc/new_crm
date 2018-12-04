package cn.tencent.crm.query;


public class DepartmentQuery extends BaseQuery {
	    //managerId
		private Integer managerId;//接收经理id的查询条件
		//parentId
		private Integer parentId;//接收上级部门id的查询条件
		
		//state查询条件的接收：
		private int state =-2;//默认就是-2，表示是"请选择"：建议大家有时间的时候，把这些常量值抽取到一个常量的类里


		public Integer getParentId() {
			return parentId;
		}

		public void setParentId(Integer parentId) {
			this.parentId = parentId;
		}

		public Integer getManagerId() {
			return managerId;
		}

		public void setManagerId(Integer managerId) {
			this.managerId = managerId;
		}

		public int getState() {
			return state;
		}

		public void setState(int state) {
			this.state = state;
		}
		

		

}
