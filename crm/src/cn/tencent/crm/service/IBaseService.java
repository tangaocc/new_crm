package cn.tencent.crm.service;

import java.io.InputStream;
import java.io.Serializable;
import java.util.List;

import cn.tencent.crm.query.BaseQuery;
import cn.tencent.crm.util.PageList;


/**
 * 几乎所有的Service都要实现crud所以要进行抽取
 * @author Administrator
 *
 */
public interface IBaseService<T> {
	/**
	 *添加一个对象 
	 */
	void add(T t);
	
	/**
	 * 删除一个对象
	 */
	void delete(Serializable id);
	
	/**
	 * 更新一个对象
	 * @param t
	 */
	void update(T t);
	
	/**
	 * 获取一个对象
	 * @param id
	 * @return
	 */
	T getById(Serializable id);
	
	/**
	 * 获取所有
	 * @return
	 */
	List<T> getAll();
	
	//查询分页条件
	PageList<T> queryPageData(BaseQuery baseQuery); 

	
	void addPool(T t);
	
	void delPool(Serializable id);
	
	PageList<T> findByQueryPool(BaseQuery query);


	//导入excel
		List<String[]> importExcel(InputStream stream) throws Exception;

}
