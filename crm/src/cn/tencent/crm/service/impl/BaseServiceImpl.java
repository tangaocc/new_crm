package cn.tencent.crm.service.impl;

import java.io.InputStream;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.tencent.crm.mapper.BaseMapper;
import cn.tencent.crm.query.BaseQuery;
import cn.tencent.crm.service.IBaseService;
import cn.tencent.crm.util.PageList;

//不需要写@Service
/**
 * 注解事务实现三部曲： 1）配置事务管理器 2）加Transactional注解 3）开发注解事务 就能识别Transactional
 * 
 * @author A
 *
 * @param <T>
 */
// 类级别应该是只读事务，因为在这个类中查询方法要多于写方法。
// 里面方法默认就继承与类级别事务（只读事务），读的方法就不用写了。只需改写的方法为写事务就ol。
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true) // SUPPORTS有就用，没有算了。
public class BaseServiceImpl<T> implements IBaseService<T> {

	@Autowired
	private BaseMapper<T> baseMapper;

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false) // 必须得有一个
	@Override
	public void add(T t) {
		System.out.println("打印一句");
		baseMapper.save(t);
		// int i = 1/0;
	}

	@Transactional // 等价于add方法上面的
	@Override
	public void delete(Serializable id) {
		baseMapper.remove(id);
	}

	@Transactional // 等价于add方法上面的
	@Override
	public void update(T t) {
		baseMapper.update(t);
	}

	@Override
	public T getById(Serializable id) {
		return baseMapper.loadById(id);
	}

	@Override
	public List<T> getAll() {
		return baseMapper.loadAll();
	}

	@Override
	public PageList<T> queryPageData(BaseQuery baseQuery) {
		PageList<T> pageList = new PageList<>();
		Integer total = baseMapper.queryPageCount(baseQuery);
		if (total > 0) {
			pageList.setTotal(baseMapper.queryPageCount(baseQuery));
			pageList.setRows(baseMapper.queryPageData(baseQuery));

		}
		return pageList;
	}


	@Override
	public void addPool(T t) {
		
		baseMapper.savePool(t);	
	}
	

	@Override
	public List<String[]> importExcel(InputStream stream) throws Exception {

		/**
		 * 在下载的action里面,调用这边的方法,传入一个文件过来,所以我们就需要读取到里面的数据;
		 * 创建工作簿,读取数据,然后把数据存入到集合里面;
		 */
		// 准备集合;
		List<String[]> dateList = new ArrayList<>();
		// 准备工作簿:读取文件输入流里面的xlsx文件:从里面把数据读取出来,装到集合里面;
		Workbook workbook = WorkbookFactory.create(stream);
		// 获取表;
		Sheet sheet = workbook.getSheetAt(0);
		// 获取所有行;
		int rowNum = sheet.getLastRowNum();
		// 遍历行:获取行对象,从1开始原因是要排除表头,表头占用了一行;
		for (int i = 1; i <= rowNum; i++) {
			// 获取行;
			Row row = sheet.getRow(i);
			// 获取所有列;
			short cellNum = row.getLastCellNum();
			// 创建行数组:一行的长度就是最大列数;
			String[] strs = new String[cellNum];
			// 遍历所有列:取出列,存值;
			for (int j = 0; j < cellNum; j++) {
				// 获得列对象;
				Cell cell = row.getCell(j);
				if(cell!=null) {
				cell.setCellType(Cell.CELL_TYPE_STRING);
				// 往行里面的列存取数据;
				strs[j] = cell.getStringCellValue();
				}
			}
			// 把每行添加进集合;
			dateList.add(strs);
		}
		System.out.println(dateList);

		return dateList;	
	}

	


	@Override
	public void delPool(Serializable id) {
		// TODO Auto-generated method stub
		baseMapper.delPool(id);
	}

	@Override
	public PageList<T> findByQueryPool(BaseQuery query) {
		//根据分页条件拿到总条数
		int totalCount = baseMapper.getTotalCountPool(query);
		//如果数据小于1 返回 ，节约资源
		if (totalCount<1) {
			return new PageList<>();
		}
		//拿到分页后的总数据
		List<T> datas = baseMapper.getLimitDatasPool(query);
		return new PageList<>(totalCount, datas);
		
	}


}
