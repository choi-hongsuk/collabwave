package com.gdu.myapp.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReferMapper {
	int register(String content);
}