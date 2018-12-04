package cn.tencent.crm.query;

import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import cn.tencent.crm.domain.Employee;
import cn.tencent.crm.domain.Role;
import cn.tencent.crm.util.UserContext;

public class CustomerQuery extends BaseQuery {
	private Integer state = -2;

	// 创建人
	private Long inputUserId; // null表示不做过滤

	// 客户来源
	private Long customerSourceId;// null表示不做过滤
	//职业
	private Long jobId;
	//销售人员
	private Long sellerId;
	
	private Long salaryLevelId;
	
	//拿登陆者ID
	public Long getLoginUserId(){
		if(UserContext.LOGIN_USER_IN_SESSION !=null){
			Employee loginUser = UserContext.getUser();
			return loginUser.getId();
		}else {
			return null;
		}
	}
	
	//返回true表示是超级管理员和销售经理
	public boolean getIsAdminOrMarketManager(){
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		if (session==null) {
			return false;
		}else {
			Employee loginUser = UserContext.getUser();
			List<Role> roles = loginUser.getRoles();
			for (Role role : roles) {
				if (role.getSn().endsWith("Admin") || role.getSn().endsWith("MarketManager")) {
					return true;
				}
			}
			return false;
		}
		
	}
	
	

	public Long getSalaryLevelId() {
		return salaryLevelId;
	}

	public void setSalaryLevelId(Long salaryLevelId) {
		this.salaryLevelId = salaryLevelId;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Long getInputUserId() {
		return inputUserId;
	}

	public void setInputUserId(Long inputUserId) {
		this.inputUserId = inputUserId;
	}

	public Long getCustomerSourceId() {
		return customerSourceId;
	}

	public void setCustomerSourceId(Long customerSourceId) {
		this.customerSourceId = customerSourceId;
	}

	public Long getJobId() {
		return jobId;
	}

	public void setJobId(Long jobId) {
		this.jobId = jobId;
	}

	public Long getSellerId() {
		return sellerId;
	}

	public void setSellerId(Long sellerId) {
		this.sellerId = sellerId;
	}

	
	
}
