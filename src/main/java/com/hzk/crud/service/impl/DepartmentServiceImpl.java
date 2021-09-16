package com.hzk.crud.service.impl;

import com.hzk.crud.dao.DepartmentMapper;
import com.hzk.crud.pojo.Department;
import com.hzk.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author huangSir
 * @version 1.0
 */
@Service
public class DepartmentServiceImpl implements DepartmentService {
    @Autowired
    DepartmentMapper departmentMapper;

    public List<Department> getDepts() {
        return departmentMapper.selectByExample(null);
    }
}
