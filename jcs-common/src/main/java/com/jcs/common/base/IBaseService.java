package com.jcs.common.base;


import com.github.pagehelper.PageInfo;

import java.util.HashMap;
import java.util.List;

public interface IBaseService<T> {

    /**
     * 保存
     *
     * @param t
     * @return
     */
    int save(T t);

    /**
     * 通过Id 查询
     *
     * @param id
     * @return
     */
    T findOneById(Long id);


    /**
     * 通过参数条件查询
     *
     * @param t
     * @return
     */
    T findOneByParams(T t);

    /**
     * 通过Id 删除
     *
     * @param id
     * @return
     */
    int delById(Long id);

    /**
     * 更新
     *
     * @param t
     * @return
     */
    int update(T t);


    /**
     * 获取列表
     *
     * @param t
     * @return
     */
    List<T> findByList(T t);


    /**
     * 查询通过参数
     *
     * @param params
     * @return
     */
    List<T> findByParams(HashMap<String, Object> params);

    /**
     * 分页查询列表
     *
     * @param params
     * @param pageNum
     * @param pageSize
     * @return
     */
    PageInfo<T> findListByPage(HashMap<String, Object> params, Integer pageNum, Integer pageSize);

}
