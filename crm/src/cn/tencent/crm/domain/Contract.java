package cn.tencent.crm.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 合同管理
 * @author 宸豪
 *
 */
public class Contract {
	//ID
	private Long id;
	//合同单号
	private Date sn = new Date();
	//合同客户
	private Customer customer;
	//签订时间
	private Date signTime = new Date();
	//营销人员
	private Employee seller;
	//合同金额
	private Long sum;
	//合同摘要
	private String intro;
	//付款详情
	private List<ContractItem> details = new ArrayList<>();
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Date getSn() {
		return sn;
	}
	public void setSn(Date sn) {
		this.sn = sn;
	}
	
	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	public Date getSignTime() {
		return signTime;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public void setSignTime(Date signTime) {
		this.signTime = signTime;
	}
	public Employee getSeller() {
		return seller;
	}
	public void setSeller(Employee seller) {
		this.seller = seller;
	}
	public Long getSum() {
		return sum;
	}
	public void setSum(Long sum) {
		this.sum = sum;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public List<ContractItem> getDetails() {
		return details;
	}
	public void setDetails(List<ContractItem> details) {
		this.details = details;
	}
	@Override
	public String toString() {
		return "Contract [id=" + id + ", sn=" + sn + ", signTime=" + signTime + ", seller=" + seller + ", sum=" + sum
				+ ", intro=" + intro + "]";
	}
	public Contract(Long id, Date sn, Customer customer, Date signTime, Employee seller, Long sum, String intro,
			List<ContractItem> details) {
		super();
		this.id = id;
		this.sn = sn;
		this.customer = customer;
		this.signTime = signTime;
		this.seller = seller;
		this.sum = sum;
		this.intro = intro;
		this.details = details;
	}
	public Contract() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
}
