package cn.tencent.crm.query;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import cn.tencent.crm.domain.Customer;
import cn.tencent.crm.domain.Employee;

public class OrderQuery extends BaseQuery{
	
	private Long state;
	private Date signTime;
	private Integer customerId;
	private Integer sellerId;
	
	
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	public Date getSignTime() {
		return signTime;
	}
	 @DateTimeFormat(pattern = "yyyy-MM-dd")
	public void setSignTime(Date signTime) {
		this.signTime = signTime;
	}
	 
	 


	public Integer getCustomerId() {
		return customerId;
	}
	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}
	public Integer getSellerId() {
		return sellerId;
	}
	public void setSellerId(Integer sellerId) {
		this.sellerId = sellerId;
	}
	public Long getState() {
		return state;
	}

	public void setState(Long state) {
		this.state = state;
	}
	@Override
	public String toString() {
		return "OrderQuery [state=" + state + ", signTime=" + signTime + ", customerId=" + customerId + ", sellerId="
				+ sellerId + "]";
	}
	
	
	
	
	
}
