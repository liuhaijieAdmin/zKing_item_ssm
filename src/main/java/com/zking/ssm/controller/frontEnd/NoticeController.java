package com.zking.ssm.controller.frontEnd;

import com.zking.ssm.model.Dict;
import com.zking.ssm.model.Notice;
import com.zking.ssm.model.User;
import com.zking.ssm.service.IDictService;
import com.zking.ssm.service.INoticeService;
import com.zking.ssm.utils.PageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@Controller
@RequestMapping(value = "/notice")
public class NoticeController {

    @Autowired
    private INoticeService iNoticeService;
    @Autowired
    private IDictService iDictService;

    @ModelAttribute
    public void init(Model model){
        Notice notice = new Notice();
        model.addAttribute("notice",notice);
    }

    @RequestMapping(value = "/loadService")
    public ModelAndView loadService(Notice n, ModelAndView modelAndView, HttpServletRequest request){

        Notice loadNotice = iNoticeService.selectByPrimaryKey(n.getNid());

        PageBean pageBean = new PageBean();

        List<Notice> listNotice = iNoticeService.listNotice(n, pageBean);

        modelAndView.addObject("pageBean",pageBean);
        modelAndView.addObject("listNotice",listNotice);
        modelAndView.addObject("notice",loadNotice);

        modelAndView.setViewName("frontEnd/service");

        return modelAndView;
    }

    @RequestMapping(value = "/listNews")
    public ModelAndView listNews(Notice n, ModelAndView modelAndView, HttpServletRequest request){

        n.setDictItem("新闻资讯");
        PageBean pageBean = new PageBean();
        List<Notice> listNotice = iNoticeService.listNotice(n, pageBean);

        modelAndView.addObject("pageBean",pageBean);
        modelAndView.addObject("listNotice",listNotice);

        modelAndView.setViewName("frontEnd/news");

        return modelAndView;
    }

    @RequestMapping(value = "/loadNews")
    public ModelAndView loadNews(Notice n, ModelAndView modelAndView, HttpServletRequest request){

        Notice loadNotice = iNoticeService.selectByPrimaryKey(n.getNid());

        PageBean pageBean = new PageBean();

        List<Notice> listNotice = iNoticeService.listNotice(n, pageBean);

        modelAndView.addObject("pageBean",pageBean);
        modelAndView.addObject("listNotice",listNotice);
        modelAndView.addObject("notice",loadNotice);

        modelAndView.setViewName("frontEnd/news_details");

        return modelAndView;
    }

    @RequestMapping(value = "/listProblem")
    public ModelAndView listProblem(Notice n, ModelAndView modelAndView, HttpServletRequest request){

        n.setDictItem("常见问题");
        PageBean pageBean = new PageBean();
        List<Notice> listNotice = iNoticeService.listNotice(n, pageBean);

        modelAndView.addObject("pageBean",pageBean);
        modelAndView.addObject("listNotice",listNotice);

        modelAndView.setViewName("frontEnd/problem");

        return modelAndView;
    }

    @RequestMapping(value = "/loadProblem")
    public ModelAndView loadProblem(Notice n, ModelAndView modelAndView, HttpServletRequest request){

        Notice loadNotice = iNoticeService.selectByPrimaryKey(n.getNid());

        PageBean pageBean = new PageBean();

        List<Notice> listNotice = iNoticeService.listNotice(n, pageBean);

        modelAndView.addObject("pageBean",pageBean);
        modelAndView.addObject("listNotice",listNotice);
        modelAndView.addObject("notice",loadNotice);

        modelAndView.setViewName("frontEnd/problem_details");

        return modelAndView;
    }


    @RequestMapping(value = "/aboutUs")
    public ModelAndView aboutUs(Notice n, ModelAndView modelAndView, HttpServletRequest request){

        Notice loadNotice = iNoticeService.selectByPrimaryKey(n.getNid());

        n.setDictItem("关于我们");
        PageBean pageBean = new PageBean();

        List<Notice> listNotice = iNoticeService.listNotice(n, pageBean);
        modelAndView.addObject("pageBean",pageBean);
        modelAndView.addObject("listNotice",listNotice);
        modelAndView.addObject("notice",loadNotice);

        modelAndView.setViewName("frontEnd/aboutUs");

        return modelAndView;
    }

    @RequestMapping(value = "/noticeList")
    public ModelAndView noticeList(Notice n, ModelAndView modelAndView, HttpServletRequest request){
        PageBean pageBean = new PageBean();
        pageBean.setRequest(request);
        pageBean.setRows(5);
        List<Notice> listNotice = iNoticeService.listNotice(n, pageBean);
        modelAndView.addObject("pageBean",pageBean);
        modelAndView.addObject("listNotice",listNotice);
        modelAndView.setViewName("admin/notice_list");

        return modelAndView;

    }

    @RequestMapping(value = "/toaddNotice")
    public String toaddNotice(Notice n,HttpServletRequest request){
        Dict dict = new Dict();
        dict.setDictValue("groupby");
        List<Dict> dicts = iDictService.listDict(dict, null);
        request.setAttribute("dicts",dicts);
        return "admin/notice_compile";
    }

    @RequestMapping(value = "/addNotice")
    public String addNotice(Notice n){
        boolean b = iNoticeService.insertSelective(n)>0?true:false;
        return "redirect:/notice/toaddNotice";
    }


    @RequestMapping("/noticeDel")
    public void noticeDel(String id,HttpServletResponse response)throws IOException {
        PrintWriter out = response.getWriter();
        Notice notice = new Notice();
        int toid = 0;
        boolean b = false;
        try {
            toid = Integer.parseInt(id);
            b = iNoticeService.deleteByPrimaryKey(toid)>0?true:false;
            if(b) out.print("1");else out.print("0");
        }catch (Exception e){
            //System.out.println("转型异常----执行以下方法");
            String[] split = id.split(",");
            for (int i=0;i<split.length;i++){
                b = iNoticeService.deleteByPrimaryKey(Integer.parseInt(split[i]))>0?true:false;
            }
            if(b) out.print("1");else out.print("0");
        }
    }

    @RequestMapping("/noticeStatus")
    public void updateKey(String id,String status,HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        Notice user = new Notice();
        user.setNid(Integer.parseInt(id));
        user.setNstatus( Integer.parseInt(status));
        boolean b = iNoticeService.updateByPrimaryKeySelective(user)>0?true:false;
        if(b) out.print("1");else out.print("0");
    }

    @RequestMapping(value = "/doupdateNotice")
    public ModelAndView doupdateNotice(String nid,ModelAndView modelAndView){
        System.out.println("nid============="+nid);
        Dict dict = new Dict();
        dict.setDictValue("groupby");
        List<Dict> dicts = iDictService.listDict(dict, null);
        int n = 0;
        try {
            n = Integer.parseInt(nid);
        }catch (Exception e){
            n = Integer.parseInt(nid.split(",")[0]);
            modelAndView.addObject("state","ok");
        }
        Notice notice  = iNoticeService.selectByPrimaryKey(n);
        modelAndView.addObject("dicts",dicts);
        modelAndView.addObject("notice",notice);
        modelAndView.setViewName("admin/notice_update");
        return modelAndView;
    }

    @RequestMapping(value = "/updateNotice")
    public String updateNotice(Notice notice,ModelAndView modelAndView){
       boolean f =   iNoticeService.updateByPrimaryKeySelective(notice)>0?true:false;
       return "forward:/notice/doupdateNotice?nid="+notice.getNid();
    }


}
