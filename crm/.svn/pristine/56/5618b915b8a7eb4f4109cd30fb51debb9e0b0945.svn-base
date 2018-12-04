package cn.tencent.crm.domain;
/*数据项	字段	说明	输入格式	是否必填
ID	id	主键，系统自动生成	数据库自动生成	
字典目录	parent	多对一	字典目录对象	是
字典明细名称	name		文本	是
字典明细序号	requence		数字	
字典明细简介	intro		文本	*/
/**
 * 数据字典明细
 * @author Lenovo
 */
public class SystemDictionaryItem {
	
	private Long id; // ID 主键，系统自动生成 数据库自动生成
	private String name;// 字典明细名称 文本 是
	private Long requence;// 字典明细序号 数字
	private String intro;// 字典明细简介 文本 */
	private SystemDictionary parent;// 字典目录    多对一 字典目录对象 是
	public String getText(){
		return this.name;
	}
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	public SystemDictionary getParent() {
		return parent;
	}

	public void setParent(SystemDictionary parent) {
		this.parent = parent;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Long getRequence() {
		return requence;
	}
	public void setRequence(Long requence) {
		this.requence = requence;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public SystemDictionaryItem() {
		super();
	}
	@Override
	public String toString() {
		return "SystemDictionaryItem [id=" + id + ", name=" + name + ", requence=" + requence + ", intro=" + intro
				+ "]";
	}
	

}
