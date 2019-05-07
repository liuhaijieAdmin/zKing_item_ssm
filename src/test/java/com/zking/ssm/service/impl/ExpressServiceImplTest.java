package com.zking.ssm.service.impl;

import com.zking.ssm.model.Express;
import com.zking.ssm.service.IExpressService;
import com.zking.ssm.service.impl.base.BaseTestCase;
import com.zking.ssm.utils.PageBean;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

import static org.junit.Assert.*;

public class ExpressServiceImplTest extends BaseTestCase {

    @Autowired
    private IExpressService iExpressService;

    private Express express;

    @Override
    public void before() {
        super.before();
        express = new Express();
    }

    @Test
    public void deleteByPrimaryKey() {
    }

    @Test
    public void insert() {
        for (int i =0;i<10;i++){
            express.setOrderid("23125544335113445321"+i);
            express.setOrdername("一把伞"+i);
            express.setOrderprice(50f+i);
            express.setOrdervolume("10");
            express.setOrderweight("15");
            express.setOrderremark("这个是一个备注"+i);
            express.setOrderaddress("上海");
            express.setShipper("大刘");
            express.setShipperaddress("云南");
            express.setShipperphone("1845465455");
            express.setConsignee("小刘");
            express.setConsigneeaddress("黑龙江");
            express.setConsigneephone("18489498489");
            express.setUid(1);
            boolean b = iExpressService.insertSelective(express);
            System.out.println(b);
        }
    }

    @Test
    public void insertSelective() {
    }

    @Test
    public void selectByPrimaryKey() {
    }

    @Test
    public void updateByPrimaryKeySelective() {

    }

    @Test
    public void updateByPrimaryKey() {
    }

    @Test
    public void expressList() {
        PageBean pageBean = new PageBean();
        pageBean.setRows(1);
        List<Express> expresses = iExpressService.listExpress(express, pageBean);
        for (Express express1 : expresses) {
            System.out.println("express1:-----"+express1.toString());
        }
        List<Express> expresses1 = iExpressService.listExpress(express, pageBean);
        for (Express express1 : expresses1) {
            System.out.println("express1:-----"+express1.toString());
        }

    }
}