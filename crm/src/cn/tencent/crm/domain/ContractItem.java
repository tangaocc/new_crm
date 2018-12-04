package cn.tencent.crm.domain;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 合同付款明细
 * @author 宸豪
 *
 */
public class ContractItem {
	//ID
	private Long id;
	//所属合同
	private Contract contract;
	//付款时间
	private Date payTime = new Date();
	//付款金额
	private Long money;
	//所占比例
	private Long scale;
	//是否付款
	private Boolean isPayment;

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Contract getContract() {
		return contract;
	}
	public void setContract(Contract contract) {
		this.contract = contract;
	}
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	public Date getPayTime() {
		return payTime;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}
	public Long getMoney() {
		return money;
	}
	public void setMoney(Long money) {
		this.money = money;
	}
	public Long getScale() {
		return scale;
	}
	public void setScale(Long scale) {
		this.scale = scale;
	}
	public Boolean getIsPayment() {
		return isPayment;
	}
	public void setIsPayment(Boolean isPayment) {
		this.isPayment = isPayment;
	}
	public ContractItem() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public ContractItem(Long id, Contract contract, Date payTime, Long money, Long scale, Boolean isPayment) {
		super();
		this.id = id;
		this.contract = contract;
		this.payTime = payTime;
		this.money = money;
		this.scale = scale;
		this.isPayment = isPayment;
	}
	@Override
	public String toString() {
		return "ContractItem [id=" + id + ", contract=" + contract + ", payTime=" + payTime + ", money=" + money
				+ ", scale=" + scale + ", isPayment=" + isPayment + "]";
	}
	
	
}
