package cn.tencent.crm.query;

public class BaseQuery {
	//为了兼容easyui的分页组件:相当于以前的：currentPage
	private int page = 1;
	//每页条数:相当于以前的：pageSize
	private int rows = 10;
	
	private int getStart(){
		//(currentPage-1)*pageSize
		return (page-1)*rows;
	}
	
	private String q;//easyui查询的关键字的参数
	
	
	public String getQ() {
		return q;
	}


	public void setQ(String q) {
		this.q = q;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	@Override
	public String toString() {
		return "BaseQuery [page=" + page + ", rows=" + rows + "]";
	}
	
	
	
}
