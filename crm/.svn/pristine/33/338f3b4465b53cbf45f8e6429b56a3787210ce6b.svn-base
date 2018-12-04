package cn.tencent.crm.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 客户
 * @author Administrator
 *
 */
public class Customer {
	/*基本数据*/
	//编号	id	系统自动生成	输入框只读
	private Long id;
	//客户姓名	name 日期	必填
	private String name;
	//客户年龄 age	文本	必填
	private String age;
	//客户性别	数字	必填  男 为: 1 ; 女为: -1, 未知 为:0
	private Integer gender;
	
	/*联系方式*/
	//电话号码		文本	是
	private String tel;
	//邮箱	email	文本	
	private String email;
	//QQ	qq		文本	
	private Integer qq;
	//微信	wechat		文本
	private String wechat;
	
	/*扩展信息*/
	//营销人员	seller		员工对象
	private Employee seller;
	//职业	job		数据字典
	private SystemDictionaryItem job;
	//收入水平	salaryLevel		数据字典
	private SystemDictionaryItem salaryLevel;
	//客户来源	customerSource		数据字典
	private SystemDictionaryItem customerSource;
	//创建人	inputUser	自动填入当前登录用户，用户不可更改	输入框只读	必填
	private Employee inputUser;
	//创建时间	inputTime	当前系统时间	输入框只读	必填
	private Date inputTime;
	//客户状态 =0正式客户  =-1潜在客户
	private Integer state=0;
	
	public String getText(){
		return name;
	}
	
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
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public Integer getGender() {
		return gender;
	}
	public void setGender(Integer gender) {
		this.gender = gender;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public Integer getQq() {
		return qq;
	}
	public void setQq(Integer qq) {
		this.qq = qq;
	}
	public String getWechat() {
		return wechat;
	}
	public void setWechat(String wechat) {
		this.wechat = wechat;
	}
	public Employee getSeller() {
		return seller;
	}
	public void setSeller(Employee seller) {
		this.seller = seller;
	}
	public SystemDictionaryItem getJob() {
		return job;
	}
	public void setJob(SystemDictionaryItem job) {
		this.job = job;
	}
	public SystemDictionaryItem getSalaryLevel() {
		return salaryLevel;
	}
	public void setSalaryLevel(SystemDictionaryItem salaryLevel) {
		this.salaryLevel = salaryLevel;
	}
	public SystemDictionaryItem getCustomerSource() {
		return customerSource;
	}
	public void setCustomerSource(SystemDictionaryItem customerSource) {
		this.customerSource = customerSource;
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
	public Customer() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "Customer [id=" + id + ", name=" + name + ", age=" + age + ", gender=" + gender + ", tel=" + tel
				+ ", email=" + email + ", qq=" + qq + ", wechat=" + wechat + ", inputTime=" + inputTime + ", state="
				+ state + "]";
	}
	
	
	
	
}
