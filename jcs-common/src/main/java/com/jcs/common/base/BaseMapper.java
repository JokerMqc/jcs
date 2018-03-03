package com.jcs.common.base;

import org.apache.ibatis.annotations.Param;

import java.util.HashMap;
import java.util.List;

/**
 *  @Description :
 *      mapper 基类
 *  @author : Hzhan
 *  @Date : create in 2018-01-29
 *
 **/
public interface BaseMapper<T> {


    /**
     *  保存方法 返回主键Id(针对有主键的)
     * @param t
     * @return
     */
    int insert(T t);


    /**
     *  删除 通过Id删除
     * @param id
     * @return
     */
    int delById(@Param("id") Long id);

    /**
     *  更新方法
     * @param t
     * @return
     */
    int update(T t);

    /**
     *  查询 通过实体查询
     * @param t
     * @return
     */
    T findOneByParams(T t);

    /**
     *  查询 通过Id
     * @param id
     * @return
     */
    T findOneById(@Param("id") Long id);


    /**
     *  查询列表
     * @param t
     * @return
     */
    List<T> findByList(T t);

    /**
     *  查询列表 通过参数
     * @param params
     * @return
     */
    List<T> findByParams(HashMap<String, Object> params);

    /**
     *  获取总条数
     * @param t
     * @return
     */
    int getTotal(T t);

}
