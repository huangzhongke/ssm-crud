package com.hzk.crud.test;

import com.hzk.crud.pojo.Department;
import com.hzk.crud.service.DepartmentService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 * @author huangSir
 * @version 1.0
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:ApplicationContext.xml"})
public class DepartTest {
    @Autowired
    DepartmentService departmentService;
    @Test
    public void getDepts(){
        List<Department> depts = departmentService.getDepts();
        for (Department dept : depts) {
            System.out.println(dept.getDeptName());
        }
    }

}
