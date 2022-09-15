package com.tainguyen.demo.controllers;

import com.tainguyen.demo.model.News;
import com.tainguyen.demo.model.User;
import com.tainguyen.demo.repository.IntroRepository;
import com.tainguyen.demo.repository.NewsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.Objects;

@Controller
public class NewsController extends BaseController {

	@Autowired
	private NewsRepository newsRepository;

	@Autowired
	private IntroRepository introRepository;

	@PostMapping("addNews")
	public String addNews(HttpServletRequest request, HttpServletResponse response)
			throws IOException {

		String value = request.getParameter("news");
		String title = request.getParameter("title");
		String thumbnail = request.getParameter("thumbnail");
		User currentUser = getCurrentUser();

		News news = new News();
		news.setContent(value);
		news.setTitle(title);
		news.setThumbnail(thumbnail);
		news.setIntro(false);

		if (Objects.nonNull(currentUser)) {
			news.setUserId(currentUser.getUserID());
		}

		try {
			boolean save = newsRepository.addNews(news);
			if (save) {
				return "redirect:/admin/news_list";
			}

		} catch (SQLException e) {
			System.out.println(e);
		}
		return null;
	}

	@GetMapping("news_list")
	public String news(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		String offset = request.getParameter("offset");
		String limit = request.getParameter("limit");

		request.setAttribute("offset", offset);
		request.setAttribute("limit", limit);

		return "admin/news_list";
	}

	@GetMapping("news")
	public String getNewsById(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		try {
			Long newsId = Long.valueOf(request.getParameter("news_id"));
			request.setAttribute("news_id", newsId);
			return "admin/news";

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@GetMapping("delete_news")
	public String deleteNews(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		try {
			Long newsId = Long.valueOf(request.getParameter("news_id"));
			if (Objects.nonNull(newsId)) {
				if (newsRepository.deleteNews(newsId))
				return "redirect:/admin/news_list";
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@GetMapping("pick_news")
	public String pickNews(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		try {
			Long newsId = Long.valueOf(request.getParameter("news_id"));
			if (Objects.nonNull(newsId)) {
				if (introRepository.pickNews(newsId))
					return "redirect:/admin/news_list";
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@PostMapping("editNews")
	public String editNews(HttpServletRequest request, HttpServletResponse response)
			throws IOException {

		String value = request.getParameter("news");
		String title = request.getParameter("title");
		long news_id = Long.parseLong(request.getParameter("news_id"));
		String thumbnail = request.getParameter("thumbnail");

		News news = new News();
		news.setId(news_id);
		news.setContent(value);
		news.setTitle(title);
		news.setThumbnail(thumbnail);
		try {
			boolean save = newsRepository.editNews(news);
			if (save) {
				return "redirect:/admin/news_list";
			}

		} catch (SQLException e) {
			System.out.println(e);
		}
		return null;
	}

	@GetMapping("/user/news_list")
	public String userListnews(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		String offset = request.getParameter("offset");
		String limit = request.getParameter("limit");

		request.setAttribute("offset", offset);
		request.setAttribute("limit", limit);

		return "news_list";
	}

	@GetMapping("user/news")
	public String userGetNewsById(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		try {
			Long newsId = Long.valueOf(request.getParameter("news_id"));
			request.setAttribute("news_id", newsId);
			return "news";

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@GetMapping("intro")
	public String getIntro(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		try {
			Long newsId = introRepository.getIntroduceId();
			request.setAttribute("news_id", newsId);
			return "intro";

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
