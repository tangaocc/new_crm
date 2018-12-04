package cn.tencent.crm.domain;

import java.util.ArrayList;
import java.util.List;

/**
 * 
 * 系统菜单
 * @author Lenovo
 *
 */

public class SystemMenu {
	private Long id;
	private String sn; // 菜单编号(必填)
	private String name; // 菜单名称(必填)
	private String icon; // 图标
	private String url; // 地址
	private String intro; // 简介

	private SystemMenu parent; // 上级菜单

	// 定义集合来装字菜单;
	private List<SystemMenu> children = new ArrayList<>();

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

	/**
	 * 解决easyui不能加载name字段,需要text的问题
	 * 
	 * @return
	 */
	public String getText() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}


	/**
	 * 解决菜单图标问题;
	 * @return
	 */
	public String getIconCls() {
		return icon;
	}
	
	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public SystemMenu getParent() {
		return parent;
	}

	public void setParent(SystemMenu parent) {
		this.parent = parent;
	}

	public List<SystemMenu> getChildren() {
		return children;
	}

	public void setChildren(List<SystemMenu> children) {
		this.children = children;
	}
	public SystemMenu() {
		super();
	}
	@Override
	public String toString() {
		return "SystemMenu [id=" + id + ", sn=" + sn + ", name=" + name + ", icon=" + icon + ", url=" + url + ", intro="
				+ intro + "]";
	}
}
