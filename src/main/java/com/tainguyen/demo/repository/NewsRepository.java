package com.tainguyen.demo.repository;

import com.tainguyen.demo.connect.DBConnect;
import com.tainguyen.demo.model.News;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Component;

import java.sql.*;
import java.util.ArrayList;

@Component
public class NewsRepository {

	@Autowired
	private DriverManagerDataSource dataSource;

	public ArrayList<News> getListNews(int limit, int offset) throws SQLException {
		Connection connection = DBConnect.getConnecttion();
		String sql = "SELECT * FROM news ORDER BY created_at DESC limit ? offset ?";
		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setInt(1, limit);
		ps.setInt(2, offset);
		ResultSet rs = ps.executeQuery();
		ArrayList<News> list = new ArrayList<>();
		while (rs.next()) {
			News news = new News();
			news.setContent(rs.getString("content"));
			news.setTitle(rs.getString("title"));
			news.setCreateAt(rs.getTimestamp("created_at").toInstant());
//			news.setModifyAt(rs.getTimestamp("modified_at").toInstant());
			news.setUserId(rs.getLong("user_id"));
			news.setId(rs.getLong("id"));
			news.setThumbnail(rs.getString("thumbnail"));
			list.add(news);
		}
		return list;
	}

	public boolean addNews(News news) throws SQLException {
		Connection connection = DBConnect.getConnecttion();
		String sql = "INSERT INTO news (content, user_id, title, thumbnail, created_at, is_intro) " +
				" values( ?, ?, ?, ?, ?, ?)";

		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setString(1, news.getContent());
		ps.setLong(2, news.getUserId());
		ps.setString(3, news.getTitle());
		ps.setString(4, news.getThumbnail());
		ps.setTimestamp(5, Timestamp.from(news.getCreateAt()));
		ps.setBoolean(6, news.isIntro());

		int i = ps.executeUpdate();
		if (i == 1) {
			return true;
		}
		return false;
	}

	public boolean editNews(News news) throws SQLException {
		Connection connection = DBConnect.getConnecttion();
		String sql = "UPDATE news SET content = ?, user_id = ?, title = ?, thumbnail = ?, modified_at = ? WHERE id = ?";
		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setString(1, news.getContent());
		ps.setLong(2, news.getUserId());
		ps.setString(3, news.getTitle());
		ps.setString(4, news.getThumbnail());
		ps.setTimestamp(5, Timestamp.from(news.getModifyAt()));
		ps.setLong(6, news.getId());
		int i = ps.executeUpdate();
		if (i == 1) {
			return true;
		}
		return false;
	}

	public boolean deleteNews(Long newsId) throws SQLException {
		Connection connection = DBConnect.getConnecttion();
		String sql = "DELETE from news WHERE id = ?";
		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setLong(1, newsId);
		int i = ps.executeUpdate();
		if (i == 1) {
			return true;
		}
		return false;
	}

	public News getNewsById(Long newsId) {
		Connection connection = DBConnect.getConnecttion();
		String sql = "SELECT * FROM news where id = ?";
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement(sql);
			ps.setLong(1, newsId);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				News news = new News();
				news.setContent(rs.getString("content"));
				news.setTitle(rs.getString("title"));
				news.setUserId(rs.getLong("user_id"));
				news.setThumbnail(rs.getString("thumbnail"));
				news.setCreateAt(rs.getTimestamp("created_at").toInstant());
				news.setId(newsId);
//				news.setModifyAt(rs.getTimestamp("modified_at").toInstant());
				return news;
			}

		} catch (SQLException throwables) {
			throwables.printStackTrace();
		}
		return null;
	}
}
