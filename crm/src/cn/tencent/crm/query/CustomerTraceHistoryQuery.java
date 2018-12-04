package cn.tencent.crm.query;

public class CustomerTraceHistoryQuery extends BaseQuery{
	private Long title;//主题
	
	private Integer traceResult=-2;
	
	public Integer getTraceResult() {
		return traceResult;
	}

	public void setTraceResult(Integer traceResult) {
		this.traceResult = traceResult;
	}

	private Long customerId;//客户
	
	private Long traceUserId;//跟进人
	
	private Long traceTypeId;//跟进方式

	public Long getTitle() {
		return title;
	}

	public void setTitle(Long title) {
		this.title = title;
	}

	public Long getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Long customerId) {
		this.customerId = customerId;
	}

	public Long getTraceUserId() {
		return traceUserId;
	}

	public void setTraceUserId(Long traceUserId) {
		this.traceUserId = traceUserId;
	}

	public Long getTraceTypeId() {
		return traceTypeId;
	}

	public void setTraceTypeId(Long traceTypeId) {
		this.traceTypeId = traceTypeId;
	}
	
	
}
