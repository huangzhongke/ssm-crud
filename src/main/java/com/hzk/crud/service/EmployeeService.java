package com.hzk.crud.service;

import com.hzk.crud.pojo.Employee;

import java.util.List;

/**
 * @author huangSir
 * @version 1.0
 */
public interface EmployeeService {
    List<Employee> getAll();
    void saveEmployee(Employee employee);

    boolean checkUser(String empName);


    Employee getEmp(Integer id);

    void updateEmp(Employee employee);

    void deleteEmp(Integer id);

    void deleteBatch(List<Integer> ids);
}
