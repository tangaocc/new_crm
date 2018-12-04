package cn.tencent.crm.domain;

import java.util.ArrayList;
import java.util.List;



/**第9组
 * 部门实体
 *
 * @author 梁飞你们飞哥123123
 *初始化
 *记得冲突解决了点已解决把多余临时文件删了。。。
 *
 */
public class Department {
	private Long id;                                        // ID       数据库自动生成
    private String sn;                                      // 部门编号 文本      not null (此处感觉该用数字类型, 但文档要求文本)
    private String name;                                    // 部门名称 文本      not null
    private Employee manager;                               // 部门经理 员工对象:多对一：多个部门属于一个部门经理
    private Department parent;                              // 上级部门 部门对象：多对一：多个部门有一个上级部门
    private List<Department> children = new ArrayList<>();  // 子部门   集合属性   部门对象 一对多：一个部门有多个子部门
    private String dirPath;                                 // 路径     文本
    private Integer state;                                  // 状态 0 正常 ，-1停用        数字

    public Department() {

	}
    //兼容easyui
    public String getText(){
    	return this.name;
    }
	public Department(String name) {
		this.name = name;
	}
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSn() {
        return sn;
    }

    public void setSn(String sn) {
        this.sn = sn;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Employee getManager() {
        return manager;
    }

    public void setManager(Employee manager) {
        this.manager = manager;
    }

    public Department getParent() {
        return parent;
    }

    public void setParent(Department parent) {
        this.parent = parent;
    }

    public List<Department> getChildren() {
        return children;
    }

    public void setChildren(List<Department> children) {
        this.children = children;
    }

    public String getDirPath() {
        return dirPath;
    }

    public void setDirPath(String dirPath) {
        this.dirPath = dirPath;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }


	@Override
	public String toString() {
		return "Department [id=" + id + ", sn=" + sn + ", name=" + name + ", manager=" + manager + ", parent=" + parent
				+ ", children=" + children + ", dirPath=" + dirPath + ", state=" + state + "]";
	}
	
}
