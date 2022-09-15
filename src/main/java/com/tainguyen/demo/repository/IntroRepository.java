package com.tainguyen.demo.repository;


import com.tainguyen.demo.connect.DBConnect;
import org.springframework.stereotype.Component;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@Component
public class IntroRepository {

	public Long getIntroduceId() {
		Connection connection = DBConnect.getConnecttion();
		String sql = "SELECT id FROM news where is_intro = 1";
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				Long newsId = rs.getLong("id");
				return newsId;
			}

		} catch (SQLException throwables) {
			throwables.printStackTrace();
		}
		return null;
	}

	public boolean pickNews(Long newsId) {
		Connection connection = DBConnect.getConnecttion();

		String removeOldIntro = "UPDATE news SET is_intro = 0 where is_intro = 1";

		String updateNewIntro = "UPDATE news SET is_intro = 1 where id = ?";

		try {
			PreparedStatement ps1 = connection.prepareStatement(removeOldIntro);

			if (ps1.executeUpdate() == 1) {
				PreparedStatement ps2 = connection.prepareStatement(updateNewIntro);
				ps2.setLong(1, newsId);
				if ( ps2.executeUpdate() == 1) {
					connection.close();
					return true;
				}
			}

		} catch (SQLException throwables) {
			throwables.printStackTrace();
		}
		return false;
	}
}
