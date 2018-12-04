package cn.tencent.crm.service.impl;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import java.io.Serializable;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import cn.tencent.crm.domain.Employee;
import cn.tencent.crm.domain.EmployeeRole;
import cn.tencent.crm.domain.Role;
import cn.tencent.crm.mapper.EmployeeMapper;
import cn.tencent.crm.service.IEmployeeService;
import cn.tencent.crm.util.MD5Util;
@Service
public class EmployeeServiceImpl extends BaseServiceImpl<Employee>
								implements IEmployeeService{
	
	
	@Autowired
	private EmployeeMapper employeeMapper;
/*	@Override
	public void add(Employee t) {
		t.setPassword(MD5Util.encrypt(t.getPassword()));
		employeeMapper.save(t);
	}*/
	
	/**
	 * 添加员工的时候对密码进行加密
	 */
	@Override
	public void add(Employee employee){	
		//调用工具类把密码传入进去进行加密处理;返回的是一个加密后的密码;
		String encrypt = MD5Util.encrypt(employee.getPassword());
		employee.setPassword(encrypt);	
		// 先保存角色自己的数据;
		employeeMapper.save(employee);
		/*// 先保存角色表，在保存中间表
				//只有先添加role后，才能获取其ID给中间表
				
				List<Map<String,Long>> rolePermissions = employee.getEmployeeRoleMap();
				if (rolePermissions!=null && rolePermissions.size()>0) {
					
					employeeMapper.saveEmployeeRole(employee.getEmployeeRoleMap());
				}*/
		//创建一个用来装中间表数据对象的集合
		List<EmployeeRole> empRoles = new ArrayList<EmployeeRole>();
		//从Role类中获取封装参数的Permission对象;
		List<Role> roles = employee.getRoles();
		System.out.println(roles+"------------------------------------");
		
		
		//判断此对象是否不为空且长度大于0;
		if (roles != null && roles.size() > 0) {
			//遍历这个集合,依次把role对象的id和每个permission的id取出来,封装到中间表数据对象里面去;
			for (Role role : roles) {
				empRoles.add(new EmployeeRole(employee.getId(), role.getId()));
			}
			//只有权限不为空的时候才去保存, 调用方法,保存中间表数据进数据库;
			employeeMapper.saveEmployeeRole(empRoles);
		}
		
	}
	/**
	 * 更改;
	 */
	@Override
	public void update(Employee employee) {
		//先根据角色的id把对应的权限全部删除;
		employeeMapper.removeEmployeeRole(employee.getId());
		//再添加新的中间表数据对象;
		List<EmployeeRole> empRoles = new ArrayList<EmployeeRole>();
		
		List<Role> roles = employee.getRoles();
		if (roles != null && roles.size()>0) {
			for (Role role : roles) {
				empRoles.add(new EmployeeRole(employee.getId(), role.getId()));
			}
			//再保存新的权限
			employeeMapper.saveEmployeeRole(empRoles);
		}
		//只有权限不为空的时候才去保存,更新权限自有的数据;
		super.update(employee);
	}
	
	/**
	 * 删除角色:先清空当前角色对应的所有权限,然后再删除本角色;
	 */
	@Override
	public void delete(Serializable id) {
		//;
		employeeMapper.removeEmployeeRole(id);
		//再把角色删除掉;
		super.delete(id);
	}
	

	
	
	
	
	@Override
	public Employee login(String username) {
		Employee loadByUsername = employeeMapper.loadByUsername(username);
		
		return loadByUsername;
	}
	@Override
	public Employee findByRealName(String sellerRealName) {
		return employeeMapper.findByRealName(sellerRealName);
		
	}}

