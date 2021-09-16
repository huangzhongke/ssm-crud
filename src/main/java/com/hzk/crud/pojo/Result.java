package com.hzk.crud.pojo;

import java.util.HashMap;
import java.util.Map;

/**
 * @author huangSir
 * @version 1.0
 */
public class Result {
    private int code;
    private String msg;
    private static final int SUCCESS = 0;//0代表成功
    private static final int FAIL = 1;//1 代表失败
    private Map<String, Object> obj = new HashMap<String, Object>();

    public static Result success(){
        Result result = new Result();
        result.setCode(SUCCESS);
        result.msg = "成功";
        return  result;
    }

    public static Result fail(){
        Result result = new Result();
        result.setCode(FAIL);
        result.msg = "失败";
        return  result;
    }
    public Result add(String key,Object value){
        this.obj.put(key,value);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getObj() {
        return obj;
    }

    public void setObj(Map<String, Object> obj) {
        this.obj = obj;
    }
}
