package cn.tencent.crm.mapper;

import java.io.Serializable;
import java.util.List;

import cn.tencent.crm.query.BaseQuery;



/**
 * 由于多个模块Mapper都需要crud，所以抽取父类，其他Mapper继承它。
 * @author Administrator
 *
 */
public interface BaseMapper<T> {

	/**
	 *保存一个对象 
	 */
	void save(T t);
	
	/**
	 * 移除一个对象
	 */
	void remove(Serializable id);
	
	/**
	 * 更新一个对象
	 * @param department
	 */
	void update(T t);
	
	/**
	 * 加载一个对象
	 * @param id
	 * @return
	 */
	T loadById(Serializable id);
	
	/**
	 * 加载所有
	 * @return
	 */
	List<T> loadAll();
	
	
	//分页：total和rows
	/**
	 * 查询总的条数
	 * @param query 查询条件loadDataTotal
	 * @return
	 */
	Integer queryPageCount(BaseQuery query);
	/**
	 * 查询结果
	 * @param query 查询条件  loadDataRows
	 * @return
	 */
	List<T> queryPageData(BaseQuery query);
	
	/**
	 * 资源池
	 */
	
	void savePool(T t);
	
	/**
	 * 删除资源池
	 * @param id
	 */
	void delPool(Serializable id);
	
	
	int getTotalCountPool(BaseQuery query);
	List<T> getLimitDatasPool(BaseQuery query);
}
