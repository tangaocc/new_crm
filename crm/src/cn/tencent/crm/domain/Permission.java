package cn.tencent.crm.domain;

public class Permission {
	private Long id;
	private String name;
	private String resource;
	private String sn;
    private Integer state;      // 状态 0 正常 ，-1停用        数字
	

	public Permission() {
		
	}
	//兼容easyui
    public String getText(){
    	return this.name;
    }
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public String getSn() {
		return sn;
	}
	public void setSn(String sn) {
		this.sn = sn;
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
	public String getResource() {
		return resource;
	}
	public void setResource(String resource) {
		this.resource = resource;
	}
	@Override
	public String toString() {
		return "Permission [id=" + id + ", name=" + name + ", resource=" + resource + ", sn=" + sn + ", state=" + state
				+ "]";
	}
	
    public Permission(String name, String sn, String resource,Integer state) {
		this.name = name;
		this.sn = sn;
		this.resource = resource;
		this.state = state;
    }
	
}
