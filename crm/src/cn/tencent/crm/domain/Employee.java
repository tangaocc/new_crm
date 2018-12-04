package cn.tencent.crm.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;


public class Employee {
    private Long id;            // ID        数据库自动生成
    private String username;    // 员工账号  文本      not null
    private String realName;    // 真实姓名  文本      not null
    private String password;    // 密码      文本      not null
    private String tel;         // 电话      文本      not null
    private String email;       // 邮箱      文本
    private Department department;    // 部门      文本
    private Date inputTime = new Date();     // 录入时间  日期
    private Integer state;      // 状态      数字    0 正常 ，-1离职
    private List<Role> roles = new ArrayList<Role>();
    public List<Role> getRoles() {
		return roles;
	}

    public List<Map<String, Long>> getEmployeeRoleMap() {
	    List<Map<String, Long>> list = new ArrayList<>();
	    if (getRoles().size() != 0) {
	      for (Role role : getRoles()) {
			Map<String, Long> map = new HashMap<String, Long>();
			map.put("employeeId", id);
			map.put("roleId", role.getId());
			list.add(map);
	      }
	    }
	    return list;
	  }
    
    
    
	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

	public Employee() {
	}
    
    public String getText(){
    	return this.realName;
    }
    
    public Employee(long id) {
		this.id=id;
	}

	public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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

	public Department getDepartment() {

		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getInputTime() {
        return inputTime;
    }
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setInputTime(Date inputTime) {
        this.inputTime = inputTime;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

//	public List<Role> getRoles() {
//		return roles;
//	}
//
//	public void setRoles(List<Role> roles) {
//		this.roles = roles;
//	}

	@Override
	public String toString() {
		return "Employee [id=" + id + ", username=" + username + ", realName=" + realName + ", password=" + password
				+ ", tel=" + tel + ", email=" + email + ", department=" + department + ", inputTime=" + inputTime
				+ ", state=" + state + ", roles=" + roles + "]";
	}
}

