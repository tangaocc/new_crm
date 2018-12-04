package cn.tencent.crm.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

/** 保修单明细
 * @author Administrator
 *
 */
public class RepairItem {
	
	private Long id;//id，数据库自动生成
	
	private Date repairTime;//保修时间
	
	private String repairText;//保修内容
	
	private Boolean settle;//是否解决问题   复选框
	
	private Repair repair;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	@JsonFormat(pattern="yyyy-MM-dd E HH:mm:ss",timezone="GMT+8")
	public Date getRepairTime() {
		return repairTime;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd E HH:mm:ss")
	public void setRepairTime(Date repairTime) {
		this.repairTime = repairTime;
	}

	public String getRepairText() {
		return repairText;
	}

	public void setRepairText(String repairText) {
		this.repairText = repairText;
	}

	public Boolean getSettle() {
		return settle;
	}

	public void setSettle(Boolean settle) {
		this.settle = settle;
	}

	public Repair getRepair() {
		return repair;
	}

	public void setRepair(Repair repair) {
		this.repair = repair;
	}

	@Override
	public String toString() {
		return "RepairItem [id=" + id + ", repairTime=" + repairTime + ", repairText=" + repairText + ", settle="
				+ settle + ", repair=" + repair + "]";
	}

}
