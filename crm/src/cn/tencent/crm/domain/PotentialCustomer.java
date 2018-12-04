package cn.tencent.crm.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 潜在客户
 * @author Administrator
 *
 */
public class PotentialCustomer {
	//编号  只读
	private Long id;
	//客户来源  数据字典 
	private SystemDictionaryItem customerSource;//数据字典合拼
	//客户名称  文本 必填
	private String name;
	//成功机率  数字  必填
	private Integer successRate;
	//客户描述 对潜在客户的简要备注 必填
	private String remark;
	//联系人  
	private String linkMan;
	//联系人电话  
	private String linkManTel;
	//创建人  自动填入当前登录用户，用户不可更改	输入框只读	必填
	private Employee inputUser;
	//创建时间   当前系统时间	输入框只读	必填
	private Date inputTime;
	
	
	//客户状态 =1正式客户  =0 潜在客户
	private Integer state=1;
	
	
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getLinkMan() {
		return linkMan;
	}
	public void setLinkMan(String linkMan) {
		this.linkMan = linkMan;
	}
	public String getLinkManTel() {
		return linkManTel;
	}
	public void setLinkManTel(String linkManTel) {
		this.linkManTel = linkManTel;
	}
	
	
	
	public PotentialCustomer() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	
	public PotentialCustomer(String name) {
		super();
		this.name = name;
	}
	
	public SystemDictionaryItem getCustomerSource() {
		return customerSource;
	}
	public void setCustomerSource(SystemDictionaryItem customerSource) {
		this.customerSource = customerSource;
	}
	public Integer getSuccessRate() {
		return successRate;
	}
	public void setSuccessRate(Integer successRate) {
		this.successRate = successRate;
	}
	public Employee getInputUser() {
		return inputUser;
	}
	public void setInputUser(Employee inputUser) {
		this.inputUser = inputUser;
	}
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	public Date getInputTime() {
		return inputTime;
	}
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	public void setInputTime(Date inputTime) {
		this.inputTime = inputTime;
	}
	@Override
	public String toString() {
		return "PotentialCustomer [id=" + id + ", name=" + name + ", successRate=" + successRate + ", remark=" + remark
				+ ", linkMan=" + linkMan + ", linkManTel=" + linkManTel + ", inputTime=" + inputTime + ", state="
				+ state + "]";
	}
	
	  
	
	
	
	
	
	
}
