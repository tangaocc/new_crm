package cn.tencent.crm.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

/**保修单
 * @author Administrator
 *
 */
public class Repair {
	
	private Long id;//id 数据库自动生成
	
	private Date sn = new Date();//保修单号
	
	private Integer state = 0;// 保修单的状态
	
	private Customer customer;//保修客户  非空
	
	private Contract contract;// 保修单对应的合同
	
	private Date repairTime = new Date();//保修到期时间，自客户合同项目成功履行后，开始计时1年
	
	List<RepairItem> items = new ArrayList<>();//保修单明细

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Date getRepairNumber() {
		return sn;
	}

	public void setRepairNumber(Date sn) {
		this.sn = sn;
	}
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	public Date getRepairTime() {
		return repairTime;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public void setRepairTime(Date repairTime) {
		this.repairTime = repairTime;
	}

	public List<RepairItem> getItems() {
		return items;
	}

	public void setItems(List<RepairItem> items) {
		this.items = items;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public Contract getContract() {
		return contract;
	}

	public void setContract(Contract contract) {
		this.contract = contract;
	}

	public Date getSn() {
		return sn;
	}

	public void setSn(Date sn) {
		this.sn = sn;
	}

	@Override
	public String toString() {
		return "Repair [id=" + id + ", sn=" + sn + ", state=" + state + ", customer=" + customer
				+ ", contract=" + contract + ", repairTime=" + repairTime + "]";
	}


	
}
