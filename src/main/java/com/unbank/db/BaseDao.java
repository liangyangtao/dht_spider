package com.unbank.db;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;

import com.unbank.mybatis.entity.SQLAdapter;
import com.unbank.mybatis.factory.DynamicConnectionFactory;
import com.unbank.mybatis.mapper.SQLAdapterMapper;

public class BaseDao {
	private Logger logger = Logger.getLogger(BaseDao.class);

	public void executeMapSQL(String sql, Map<String, Object> colums) {
		SqlSession sqlSession = DynamicConnectionFactory
				.getInstanceSessionFactory("development").openSession();
		try {
			SQLAdapterMapper sqlAdapterMaper = sqlSession
					.getMapper(SQLAdapterMapper.class);
			SQLAdapter sqlAdapter = new SQLAdapter();
			sqlAdapter.setSql(sql);
			sqlAdapter.setObj(colums);
			sqlAdapterMaper.executeMapSQL(sqlAdapter);
			sqlSession.commit();
		} catch (Exception e) {
			logger.error("保存数据源信息失败", e);
			sqlSession.rollback();
		} finally {
			sqlSession.close();
		}
	}

}
