package cn.tencent.crm.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 客户移交记录
 * 
 * @author Administrator
 *
 */
public class CustomerTransfer {
	//ID
	private Long id;
	//客户	customer	客户对象	必填
	private Customer customer;
	//移交人员	transUser	实行移交操作的管理人员	员工对象	必填
	private Employee transUser;
	//移交时间	transTime	日期	必填
	private Date transTime;
	//老市场专员	oldSeller	客户上的原始市场人员	员工对象	是
	private Employee oldSeller;
	//新市场专员	newSeller	由公司重新纸指派后的新市场人员	员工对象
	private Employee newSeller;
	//移交原因	transReason		文本	
	private String transReason;
	
	
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
	public Employee getTransUser() {
		return transUser;
	}
	public void setTransUser(Employee transUser) {
		this.transUser = transUser;
	}
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	public Date getTransTime() {
		return transTime;
	}
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	public void setTransTime(Date transTime) {
		this.transTime = transTime;
	}
	public Employee getOldSeller() {
		return oldSeller;
	}
	public void setOldSeller(Employee oldSeller) {
		this.oldSeller = oldSeller;
	}
	public Employee getNewSeller() {
		return newSeller;
	}
	public void setNewSeller(Employee newSeller) {
		this.newSeller = newSeller;
	}
	public String getTransReason() {
		return transReason;
	}
	public void setTransReason(String transReason) {
		this.transReason = transReason;
	}
	public CustomerTransfer() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "CustomerTransfer [id=" + id + ", transTime=" + transTime + ", transReason=" + transReason + "]";
	}
	
	
	
}
