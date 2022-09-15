package com.tainguyen.demo.model;

import lombok.Data;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Objects;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


@Data
public class News extends ModelBase {

	private static final Integer LENGTH_BRIEF = 200;

	private static final String REGEX_IMAGE = "src=\"(\\/ckeditor\\/view\\/[^\"]+)\"";

	private long id;

	private long userId;

	private String content;

	private String title;

	private String thumbnail;

	/**
	 * hungnd
	 * add isIntro
	 */
	private boolean isIntro;

	public News () {
	}

	public News (long id, long userId, String content, String title) {
		this.id = id;
		this.userId = userId;
		this.content = content;
		this.title = title;
	}

	public String createTime() {
		SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd");

		Date date = Date.from(getCreateAt());
		String dates = formatter.format(date);
		return dates;
	}

	public String briefContent() {
		if (content == null) return "";
		String converted = content.replaceAll("<.*?>", "");
		String[] result = converted.split(System.lineSeparator(), 2);
		String brief = result[0];
		if (Objects.nonNull(brief) && brief.length() < LENGTH_BRIEF) {
			return brief;
		} else
		{
			return brief.substring(0, LENGTH_BRIEF - 3) + "...";
		}
	}

	public String thumbnail() {
		if (Objects.isNull(thumbnail) || thumbnail.trim().equals("")) {
			if (getImageFromContent() != null)
				return getImageFromContent();
			return "/default-thumbnail";
		}
		return thumbnail;
	}

	private String getImageFromContent() {
		if (this.content == null) return null;
		Pattern p = Pattern.compile(REGEX_IMAGE);//. represents single character
		Matcher m = p.matcher(this.content);

		while (m.find()) {
			return m.group(1);
		}
		return null;
	}
}
