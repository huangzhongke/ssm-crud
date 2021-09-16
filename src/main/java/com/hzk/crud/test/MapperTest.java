package com.hzk.crud.test;


import com.hzk.crud.dao.DepartmentMapper;
import com.hzk.crud.dao.EmployeeMapper;
import com.hzk.crud.pojo.Department;
import com.hzk.crud.pojo.Employee;
import com.sun.scenario.effect.impl.sw.sse.SSEBlend_SRC_OUTPeer;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @author huangSir
 * @version 1.0
 * 测试dao
 */
//spring整合junit4
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:ApplicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;

    @Test
    public void testInsertEmployeeAndDepartment() {
        departmentMapper.insertSelective(new Department(null,"测试部"));
        departmentMapper.insertSelective(new Department(null,"人力资源部"));
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null,uid,"男",uid +"@163.com",1));

        }
        System.out.println("批量完成");
    }
    @Test
    public void  test(){
        System.out.println(departmentMapper);
        System.out.println(employeeMapper);
        System.out.println(sqlSession);
    }
    @Test
    public void getDepts(){

    }
}
