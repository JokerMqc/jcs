package com.jcs.common.base;

import com.github.pagehelper.PageInfo;
import com.jcs.common.result.CommonResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;

/**
 *  baseContorller
 *
 * @author : Administrator Hzhan
 * @create ：2018/1/29
 **/
public abstract class BaseController<T> {

    public abstract IBaseService<T>  getBaseService();

    /**
     * 保存方法
     *
     * @param t
     * @return
     */
    @RequestMapping("save")
    public CommonResult save(T t) {
        int reuslt = getBaseService().save(t);
        if (reuslt < 1) {
            return CommonResult.ERROR();
        } else {
            return CommonResult.SUCCESS();
        }
    }

    /**
     * 通过Id 删除
     *
     * @param id
     * @return
     */
    @RequestMapping("delById")
    public CommonResult delById(Long id) {
        int result = getBaseService().delById(id);
        if (result < 1) {
            return CommonResult.ERROR(" 删除失败! ");
        } else {
            return CommonResult.SUCCESS();
        }
    }

    /**
     * 更新
     *
     * @param t
     * @return
     */
    @RequestMapping("update")
    public CommonResult update(T t) {
        int result = getBaseService().update(t);
        if (result < 1) {
            return CommonResult.ERROR();
        } else {
            return CommonResult.SUCCESS();
        }
    }


    /**
     * 通过Map  查询
     *
     * @param t
     * @return
     */
    @RequestMapping("findOneByParams")
    public CommonResult findOneByParams(T t) {
        t = getBaseService().findOneByParams(t);
        return CommonResult.SUCCESS(t);
    }


    /**
     * 通过Id　查询
     *
     * @param id
     * @return
     */
    @RequestMapping("findOneById")
    public CommonResult findOneById(Long id) {
        T t = getBaseService().findOneById(id);
        return CommonResult.SUCCESS(t);
    }


    /**
     * 通过条件查询
     *
     * @param t
     * @return
     */
    @RequestMapping("findByList")
    public CommonResult findByList(T t) {
        List<T> list = getBaseService().findByList(t);
        return CommonResult.SUCCESS(list);
    }

    /**
     * 分页获取
     *
     * @param params
     * @param pageNum
     * @param pageSize
     * @return
     */
    @RequestMapping("findListByPage")
    public CommonResult findListByPage(@RequestParam HashMap<String, Object> params, Integer pageNum, Integer pageSize) {
        PageInfo<T> pageInfo = getBaseService().findListByPage(params, pageNum, pageSize);
        return CommonResult.SUCCESS(pageInfo);
    }

}
