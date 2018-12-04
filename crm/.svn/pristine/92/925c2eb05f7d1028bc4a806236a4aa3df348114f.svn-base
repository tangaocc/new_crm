package cn.tencent.crm.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 客户开发计划
 * @author Administrator
 *

 */
public class CustomerDevPlan {
	//编号	id	系统自动生成	输入框只读	
	private Long id;
	//计划时间	日期	
	private Date planTime;
	//计划主题  文本	必填
	private String planSubject; 
	//计划内容	计划的详细内容	文本	必填
	private String planDetails;
	//计划实施方式	计划采用如电话、邀约上门等	数据字典	必填
	private	SystemDictionaryItem planType;
	//潜在客户   潜在客户对象
	private PotentialCustomer potentialCustomer;
	//创建人		自动填入当前登录用户，用户不可更改	输入框只读	必填
	private Employee inputUser;
	//创建时间		当前系统时间	输入框只读	必填
	private Date inputTime;
	
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	public Date getPlanTime() {
		return planTime;
	}
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	public void setPlanTime(Date planTime) {
		this.planTime = planTime;
	}
	public String getPlanSubject() {
		return planSubject;
	}
	public void setPlanSubject(String planSubject) {
		this.planSubject = planSubject;
	}
	public String getPlanDetails() {
		return planDetails;
	}
	public void setPlanDetails(String planDetails) {
		this.planDetails = planDetails;
	}
	public SystemDictionaryItem getPlanType() {
		return planType;
	}
	public void setPlanType(SystemDictionaryItem planType) {
		this.planType = planType;
	}
	public PotentialCustomer getPotentialCustomer() {
		return potentialCustomer;
	}
	public void setPotentialCustomer(PotentialCustomer potentialCustomer) {
		this.potentialCustomer = potentialCustomer;
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
	public CustomerDevPlan() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "CustomerDevPlan [id=" + id + ", planTime=" + planTime + ", planSubject=" + planSubject
				+ ", planDetails=" + planDetails + ", inputTime=" + inputTime + "]";
	}
	
	
	
}
