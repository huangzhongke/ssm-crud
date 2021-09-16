package com.hzk.crud.test;

import com.hzk.crud.pojo.Employee;
import com.hzk.crud.service.EmployeeService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.swing.*;

/**
 * @author huangSir
 * @version 1.0
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:ApplicationContext.xml"})
public class EmpTest {

    @Autowired
    EmployeeService employeeService;
    @Test
    public void testCheckUser(){
        boolean b = employeeService.checkUser("张三");
        System.out.println(b);
    }
    @Test
    public void getEmP(){
        Employee emp = employeeService.getEmp(1);
        System.out.println(emp.getEmpName());
        System.out.println(emp.getEmail());
    }
    @Test
    public void updateEmp(){
        employeeService.updateEmp(new Employee(1,"1856c0","男","7777@qq.com",2));
    }
}
