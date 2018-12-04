package cn.tencent.crm.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 客户跟进历史
 * @author Administrator
 *
 */
public class CustomerTraceHistory {
	//ID
	private Long id;
	//客户	customer	跟进的哪一个客户 必填
	private Customer customer;
	//跟进人	traceUser 必填
	private Employee traceUser;
	//跟进时间	traceTime 必填
	private Date traceTime;
	//跟进方式	traceType	邀约上门、电话、短信、邮件等 必填
	private SystemDictionaryItem traceType;
	//跟进效果	traceResult	优=1、中=0、差=-1 
	private Integer traceResult;
	//跟进主题	title
	private String title;
	//备注	remark	跟进的细节，如：QQ聊天记录等
	private String remark;
	
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public Employee getTraceUser() {
		return traceUser;
	}
	public void setTraceUser(Employee traceUser) {
		this.traceUser = traceUser;
	}
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	public Date getTraceTime() {
		return traceTime;
	}
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	public void setTraceTime(Date traceTime) {
		this.traceTime = traceTime;
	}
	public SystemDictionaryItem getTraceType() {
		return traceType;
	}
	public void setTraceType(SystemDictionaryItem traceType) {
		this.traceType = traceType;
	}
	public Integer getTraceResult() {
		return traceResult;
	}
	public void setTraceResult(Integer traceResult) {
		this.traceResult = traceResult;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public CustomerTraceHistory() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "CustomerTraceHistory [id=" + id + ", traceTime=" + traceTime + ", traceResult=" + traceResult
				+ ", title=" + title + ", remark=" + remark + "]";
	}
	
	
	
	
}
