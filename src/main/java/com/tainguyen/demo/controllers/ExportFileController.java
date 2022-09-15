package com.tainguyen.demo.controllers;

import com.tainguyen.demo.controllers.utilities.FileHelper;
import com.tainguyen.demo.model.BillDto;
import com.tainguyen.demo.model.ExportFileDto;
import com.tainguyen.demo.repository.BillGet;
import com.tainguyen.demo.repository.ProductRepo;
import com.tainguyen.demo.repository.UtilityRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import static com.tainguyen.demo.controllers.utilities.FileHelper.EXCEL_EXPORT_DIRECTORY;
import static com.tainguyen.demo.controllers.utilities.FileHelper.PDF_EXPORT_DIRECTORY;

@RestController
public class ExportFileController {

	private static int PDF_MODE = 2;
	private static int EXCEL_MODE = 1;

	@Autowired
	ProductRepo productGet;

	@Autowired
	private BillGet billGet;

	@Autowired
	UtilityRepo utilityRepo;

	/**
	 * export file excel
	 **/
	@PostMapping(
			value = "/export_file_excel"
	)
	public HttpEntity<String> exportFileExcel (@RequestBody ExportFileDto exportFileDto,
	                                           HttpServletResponse response) throws IOException {

		List<String> ids = exportFileDto.getBillList();

		List<BillDto> billDtos = billGet.getHistoryByIds(ids);

		try {
			// get your file as InputStream
			String fileName = FileHelper.createExcelFile(billDtos);

			// change status "Chờ đặt" -> "Đã đặt"
			for (int i = 0; i < ids.size(); i++) {
				billGet.billMod(Long.parseLong(ids.get(i)), 2);
			}

			return new HttpEntity<>(fileName, null);

		} catch (IOException | SQLException ex) {
			throw new RuntimeException("IOError writing file to output stream");
		}
	}

	@GetMapping(value = "/download/{mode}/{fileName}")
	public ResponseEntity downloadFile(@PathVariable Integer mode, @PathVariable String fileName) throws IOException {
		HttpHeaders headers = new HttpHeaders();
		InputStream in = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String now = sdf.format(new Date());

		if (mode == EXCEL_MODE) {
			File initialFile = new File( utilityRepo.getUtilityByKey(EXCEL_EXPORT_DIRECTORY) + "/" + fileName );
			in = new FileInputStream(initialFile);
			headers.setContentType(new MediaType("application", "force-download"));
			String donwloadFileName = String.format("report_%s.xlsx", now);
			headers.set(HttpHeaders.CONTENT_DISPOSITION, String.format("attachment; filename=%s", donwloadFileName));

		} else {
			File initialFile = new File(utilityRepo.getUtilityByKey(PDF_EXPORT_DIRECTORY) + "/" + fileName );
			in = new FileInputStream(initialFile);
			headers.setContentType(new MediaType("application", "force-download"));
			String donwloadFileName = String.format("report_%s.pdf", now);
			headers.set(HttpHeaders.CONTENT_DISPOSITION, String.format("attachment; filename=%s", donwloadFileName));
		}

		return ResponseEntity
				.ok()
				.headers(headers)
				.body(new InputStreamResource(in));
	}
}
