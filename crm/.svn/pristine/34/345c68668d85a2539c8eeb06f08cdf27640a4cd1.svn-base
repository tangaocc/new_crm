package cn.tencent.crm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.tencent.crm.domain.Role;
import cn.tencent.crm.domain.SystemDictionaryItem;
import cn.tencent.crm.mapper.SystemDictionaryItemMapper;
import cn.tencent.crm.service.IRoleService;
import cn.tencent.crm.service.ISystemDictionaryItemService;

@Service
public class SystemDictionaryItemServiceImpl extends BaseServiceImpl<SystemDictionaryItem>
implements ISystemDictionaryItemService{
	@Autowired
	private SystemDictionaryItemMapper systemMapper;
	
	@Override
	public List<SystemDictionaryItem> getNameId() {
		
		return systemMapper.getIdName();
	}
}
