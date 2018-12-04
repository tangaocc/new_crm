package cn.tencent.crm.query;

public class PotentialCustomerQuery extends BaseQuery{
	private Integer state = -2;

	private Integer successRate;

	// 创建人
	private Long inputUserId; // null表示不做过滤

	// 客户来源
	private Long customerSourceId;// null表示不做过滤

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Integer getSuccessRate() {
		return successRate;
	}

	public void setSuccessRate(Integer successRate) {
		this.successRate = successRate;
	}

	public Long getInputUserId() {
		return inputUserId;
	}

	public void setInputUserId(Long inputUserId) {
		this.inputUserId = inputUserId;
	}

	public Long getCustomerSourceId() {
		return customerSourceId;
	}

	public void setCustomerSourceId(Long customerSourceId) {
		this.customerSourceId = customerSourceId;
	}

	
	
}


