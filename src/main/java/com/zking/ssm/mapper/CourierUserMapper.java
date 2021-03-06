package com.zking.ssm.mapper;

import com.zking.ssm.model.CourierUser;
import com.zking.ssm.model.User;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CourierUserMapper {
    int deleteByPrimaryKey(Integer cuid);

    int insert(CourierUser record);

    int insertSelective(CourierUser record);

    CourierUser selectByPrimaryKey(Integer cuid);

    int updateByPrimaryKeySelective(CourierUser record);

    int updateByPrimaryKey(CourierUser record);

    List<CourierUser> listCourierUser(CourierUser courierUser);
}