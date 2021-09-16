package com.hzk.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hzk.crud.pojo.Employee;
import com.hzk.crud.pojo.Result;
import com.hzk.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author huangSir
 * @version 1.0
 */
@RestController
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;

    //@RequestMapping("/emp")
   public String getEmp(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model){
        PageHelper.startPage(pn, 5);
        List<Employee> emps = employeeService.getAll();
        //可以传入连续显示的页数
        PageInfo<Employee> page = new PageInfo<Employee>(emps,5);
        model.addAttribute("page", page);
        return "list";
   }
   @RequestMapping("/emp")
   public Result getEmpJson(@RequestParam(value = "pn",defaultValue = "1") Integer pn){
       PageHelper.startPage(pn, 5);
       List<Employee> emps = employeeService.getAll();
       //可以传入连续显示的页数
       PageInfo<Employee> page = new PageInfo<Employee>(emps,5);

       return  Result.success().add("page", page);
   }
   @RequestMapping(value = "/employee" ,method = RequestMethod.POST)
   public Result saveEmp(@Valid Employee employee, BindingResult result){
       //后端校验
       if (result.hasErrors()){
           Map<String, Object> errorFields = new HashMap<String, Object>();
           List<FieldError> fieldErrors = result.getFieldErrors();
           for (FieldError fieldError : fieldErrors) {
               errorFields.put(fieldError.getField(),fieldError.getDefaultMessage());
           }
           return Result.fail().add("errorFields", errorFields);
       }else{
           System.out.println(1);
           employeeService.saveEmployee(employee);
           return Result.success();
       }
   }
   @RequestMapping("/checkUser")
   public Result checkUser(@RequestParam("empName") String empName){
       String reg= "(^[A-Za-z0-9_-]{6,16}$)|(^[\\u4e00-\\u9fa5]{2,5}$)";
       //先校验是否合法
       if(!empName.matches(reg)){
           return Result.fail().add("va_msg", "用户名长度在6-16位，中文在2-5位");
       }
       //再校验用户名是否可用
       return employeeService.checkUser(empName)? Result.success():Result.fail();
   }

   @RequestMapping(value = "/employee/{id}",method = RequestMethod.GET)
    public Result getEmp(@PathVariable("id") Integer id){
       Employee employee = employeeService.getEmp(id);
       System.out.println(employee);
       return Result.success().add("emp", employee);
   }
   @RequestMapping(value = "/employee/{empId}",method = RequestMethod.PUT)
    public Result updateEmp(Employee employee){
       //employee.setEmpId(id);
       employeeService.updateEmp(employee);
       return Result.success();
   }
   @RequestMapping(value = "/employee/{ids}",method = RequestMethod.DELETE)
    public Result deleteEmp(@PathVariable("ids") String ids){
       if(ids.contains("-")){
           //批量删除
           List<Integer> list_ids = new ArrayList<Integer>();
           String[] str_id = ids.split("-");
           for (String id : str_id) {
               list_ids.add(Integer.parseInt(id));
           }
           employeeService.deleteBatch(list_ids);
       }else {
           //单个删除
           Integer id =Integer.parseInt(ids);
           employeeService.deleteEmp(id);
       }

       return Result.success();

   }
}
