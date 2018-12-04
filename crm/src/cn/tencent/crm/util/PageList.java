package cn.tencent.crm.util;

import java.util.ArrayList;
import java.util.List;

/**
 * 封装分页查询的结果
 * @author admin
 * @LH 无修改
 *
 * @param <T>
 */
public class PageList<T> {
	/*以前pss项目的
	 * // 总页数 -> 计算出来的
	private int totalPage;
	// 当页的数据 -> 从数据库查询出来
	private List<T> result;*/

	//总条数
	private int total=0;
	//当页的数据 ->先new出来，防止没有数据的时候，传到前台为null
	private List<T> rows=new ArrayList<T>();
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public List<T> getRows() {
		return rows;
	}
	public void setRows(List<T> rows) {
		this.rows = rows;
	}
	
	public PageList(int total, List<T> rows) {
		this.total = total;
		this.rows = rows;
	}

	public PageList() {
	}
	@Override
	public String toString() {
		return "PageList [total=" + total + ", rows=" + rows + "]";
	}

}
