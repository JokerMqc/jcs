package com.jcs.common.base;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;

/**
 * 基类实现类
 *
 * @author : Administrator Hzhan
 * @create ：2018/1/29
 **/
public abstract class BaseServiceImpl<T> implements IBaseService<T> {

    /**
     *  mapper 实例
     * @return
     */
    public abstract BaseMapper<T> getBaseMapper();


    /**
     *   保存用户
     * @param t
     * @return
     */
    @Override
    @Transactional
    public int save(T t) {
        return getBaseMapper().insert(t);
    }


    /**
     *  通过Id 查询用户
     * @param id
     * @return
     */
    @Override
    public T findOneById(Long id) {
        return getBaseMapper().findOneById(id);
    }

    /**
     *  通过参数查询
     * @param t
     * @return
     */
    @Override
    public T findOneByParams(T t) {
        return getBaseMapper().findOneByParams(t);
    }

    /**
     *  通过Id 删除
     * @param id
     * @return
     */
    @Override
    @Transactional
    public int delById(Long id) {
        return getBaseMapper().delById(id);
    }

    /**
     *  更新信息
     * @param t
     * @return
     */
    @Override
    @Transactional
    public int update(T t) {
        return getBaseMapper().update(t);
    }

    /**
     *  查询列表
     * @param t
     * @return
     */
    @Override
    public List<T> findByList(T t) {
        return getBaseMapper().findByList(t);
    }

    /**
     *  其他参数查询列表
     * @param params
     * @return
     */
    @Override
    public List<T> findByParams(HashMap<String, Object> params) {
        return getBaseMapper().findByParams(params);
    }

    /**
     *  分页查询
     * @param params
     * @param pageNum
     * @param pageSize
     * @return
     */
    @Override
    public PageInfo<T> findListByPage(HashMap<String, Object> params, Integer pageNum, Integer pageSize)  {
        PageHelper.startPage(pageNum,pageSize);
        if(params.get("order")==null){
            PageHelper.orderBy(" create_time desc");
        }else{
            PageHelper.orderBy(params.get("order").toString());
        }
        List<T> list = getBaseMapper().findByParams(params);
        return new PageInfo<>(list);
    }
}
