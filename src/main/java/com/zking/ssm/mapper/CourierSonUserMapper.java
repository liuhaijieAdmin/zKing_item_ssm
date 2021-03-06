package com.zking.ssm.mapper;

import com.zking.ssm.model.CourierSonUser;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CourierSonUserMapper {
    int deleteByPrimaryKey(Integer csuid);

    int insert(CourierSonUser record);

    int insertSelective(CourierSonUser record);

    CourierSonUser selectByPrimaryKey(Integer csuid);

    int updateByPrimaryKeySelective(CourierSonUser record);

    int updateByPrimaryKey(CourierSonUser record);

    List<CourierSonUser> listCourierSonUser(CourierSonUser courierSonUser);

}