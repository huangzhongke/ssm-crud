package com.hzk.crud.controller;

import com.hzk.crud.pojo.Department;
import com.hzk.crud.pojo.Result;
import com.hzk.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.sql.ResultSet;
import java.util.List;

/**
 * @author huangSir
 * @version 1.0
 */
@RestController
public class DepartmentController {
    @Autowired
    DepartmentService departmentService;
    /**
     * 返回部门信息
     */
    @RequestMapping("/depts")
    public Result getDepts(){
        List<Department> depts = departmentService.getDepts();
        return Result.success().add("depts",depts );
    }
}
