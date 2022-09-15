package com.tainguyen.demo.model;


import lombok.Data;

@Data
public class CkEditorImage {

	private String fileName;

	private String url;

	private int uploaded;

	public CkEditorImage (String fileName) {
		this.fileName = fileName;
		this.url = "/ckeditor/view/" + fileName;
		this.uploaded = 1;
	}

	public String build () {
		return "{" + "\"url\": " + "\""  + url + "\"" + "}";
	}


}
