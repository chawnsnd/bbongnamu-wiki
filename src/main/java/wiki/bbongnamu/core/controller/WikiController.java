package wiki.bbongnamu.core.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import wiki.bbongnamu.core.exception.NotFoundWikiException;
import wiki.bbongnamu.core.service.UserService;
import wiki.bbongnamu.core.service.WikiService;
import wiki.bbongnamu.core.util.PageNavigator;
import wiki.bbongnamu.core.vo.Wiki;
import wiki.bbongnamu.core.vo.History;
import wiki.bbongnamu.core.vo.User;

@Controller
@RequestMapping("/wiki")
public class WikiController {
	private static final Logger logger = LoggerFactory.getLogger(WikiController.class);

	@Autowired
	private WikiService wikiService;
	
	@Autowired
	private UserService userService;
	
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String goSearchList(@RequestParam(name = "keyword", defaultValue = "") String keyword, 
			@RequestParam(name = "page", defaultValue = "1") int page,
			Model model) throws UnsupportedEncodingException {
		try {
			Wiki wiki = wikiService.searchWikiByTitle(keyword);
			String title = URLEncoder.encode(keyword, "UTF-8");
			return "redirect:/wiki/view?title="+title;
		} catch (NotFoundWikiException e) {
			HashMap<String, Object> map = wikiService.searchWikisByTitle(keyword, page);
			ArrayList<Wiki> wikis = (ArrayList<Wiki>) map.get("wikis");
			PageNavigator pageNavigator = (PageNavigator) map.get("pageNavigator");
			model.addAttribute("keyword", keyword);
			model.addAttribute("wikisByTitle", wikis);
			model.addAttribute("pageNavigator", pageNavigator);
			return "wiki/searchList";			
		}
	}
	
	@RequestMapping(value= "/edit", method = RequestMethod.GET)
	public String goEditForm(@RequestParam(name="title") String title, Model model) {
		Wiki wiki = null;
		try{
			wiki = wikiService.searchWikiByTitle(title);
			model.addAttribute("wiki", wiki);
			return "wiki/editForm";
		}catch (NotFoundWikiException e) {
			wiki = new Wiki();
			wiki.setTitle(title);
			model.addAttribute("wiki", wiki);
			return "wiki/editForm";
		}
	}
	
	@RequestMapping(value="/edit", method=RequestMethod.POST)
	public String edit(
			@RequestParam(name="title") String title, 
			@RequestParam(name="content") String content,
			@RequestParam(name="explanation") String explanation, 
			HttpSession session) throws UnsupportedEncodingException {
		wikiService.editWiki(title, content, (int) session.getAttribute("usernum"), explanation);
		title = URLEncoder.encode(title, "UTF-8");
		return "redirect:/wiki/view?title="+title;
	}
	
	@RequestMapping(value="/view", method=RequestMethod.GET)
	public String goView(@RequestParam(name="title") String title,
			@RequestParam(name="historynum", defaultValue = "0") int historynum,
			Model model) {
		try{
			Wiki wiki = wikiService.searchWikiByTitleAndHistorynum(title, historynum);
			model.addAttribute("wiki", wiki);
		}catch(NotFoundWikiException e){
			return "wiki/notFound";
		}
		return "wiki/view";
	}

	@RequestMapping(value="/history", method=RequestMethod.GET)
	public String goHistory(@RequestParam(name="title") String title, 
			@RequestParam(value = "page", defaultValue = "1") int page,
			Model model) {
		HashMap<String, Object> map = wikiService.searchHistories(title, page);
		ArrayList<History> histories = (ArrayList<History>) map.get("histories");
		PageNavigator pageNavigator = (PageNavigator) map.get("pageNavigator");
		for (History history : histories) {
			User user = userService.info(history.getUsernum());
			history.setUserId(user.getId());
		}
		model.addAttribute("histories", histories);
		model.addAttribute("title", title);
		model.addAttribute("pageNavigator", pageNavigator);
		return "wiki/history";
	}
	
	@RequestMapping(value="/revert", method=RequestMethod.GET)
	public String goRevert(@RequestParam(name="title") String title,
			@RequestParam(name="historynum") int historynum,
			Model model) {
		try {
			Wiki wiki = wikiService.searchWikiByTitleAndHistorynum(title, historynum);
			model.addAttribute("wiki", wiki);
			return "wiki/revert";
		} catch (NotFoundWikiException e) {
			return "wiki/notFound";
		}
	}

	@RequestMapping(value="/revert", method=RequestMethod.POST)
	public String revert(@RequestParam(name="title") String title,
			@RequestParam(name="historynum") int historynum,
			@RequestParam(name="explanation") String explanation,
			HttpSession session,
			Model model) throws UnsupportedEncodingException {
		wikiService.revertWiki(historynum, (int) session.getAttribute("usernum"), explanation);
		title = URLEncoder.encode(title, "UTF-8");
		return "redirect:/wiki/view?title="+title;
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.GET)
	public String goDelete(
			@RequestParam(name="title") String title,
			Model model){
		model.addAttribute("title", title);
		return "/wiki/delete";
	}

	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public String delete(
			@RequestParam(name="title") String title,
			@RequestParam(name="explanation") String explanation,
			HttpSession session,
			Model model) throws UnsupportedEncodingException{
		wikiService.deleteWiki(title, (int) session.getAttribute("usernum"), explanation);
		title = URLEncoder.encode(title, "UTF-8");
		return "redirect:/wiki/view?title="+title;
	}
	
	@RequestMapping(value="/random", method=RequestMethod.GET)
	public String random() throws UnsupportedEncodingException{
		try {
			String title = wikiService.searchRandomWiki().getTitle();
			title = URLEncoder.encode(title, "UTF-8");
			return "redirect:/wiki/view?title="+title;
		}catch(NullPointerException e) {
			return "wiki/notFound";
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/recent-wikis", method = RequestMethod.GET)
	public ArrayList<Wiki> recentWikis() {
		ArrayList<Wiki> wikis = wikiService.searchRecentWikis();
		return wikis;
	}
}
