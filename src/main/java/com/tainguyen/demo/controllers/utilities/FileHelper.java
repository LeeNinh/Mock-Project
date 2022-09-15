package com.tainguyen.demo.controllers.utilities;

import com.tainguyen.demo.model.BillDto;
import com.tainguyen.demo.repository.UtilityRepo;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.util.ResourceUtils;

import java.io.*;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

public class FileHelper {

	private static final String EXCEL_TEMPLATE_LOCATION = "static/templates/bill_template.xlsx";

	private static final String PDF_TEMPLATE_LOCATION = "static/templates/bill_template.jrxml";

	public static final String PDF_EXPORT_DIRECTORY = "PDF_EXPORT_DIRECTORY";
	public static final String EXCEL_EXPORT_DIRECTORY = "EXCEL_EXPORT_DIRECTORY";

	public static String createExcelFile (List<BillDto> billDtos)
			throws IOException {
		UtilityRepo utilityRepo = new UtilityRepo();

		FileInputStream file = new FileInputStream(ResourceUtils.getFile("classpath:" + EXCEL_TEMPLATE_LOCATION));
		Workbook workbook = new XSSFWorkbook(file);
		if (Objects.nonNull(billDtos)) {
			Sheet sheet = workbook.getSheetAt(0);
			CellStyle style = workbook.createCellStyle();
			style.setWrapText(true);
			style.setBorderBottom(BorderStyle.THIN);
			style.setBorderTop(BorderStyle.THIN);
			style.setBorderRight(BorderStyle.THIN);
			style.setBorderLeft(BorderStyle.THIN);

			int rowPos = 1;
			for (BillDto billDto : billDtos) {
				List<String[]> dataExports = billDto.exportExcelRow();
				for (int i = 0; i < dataExports.size(); i++) {
					Row row = sheet.createRow(rowPos + i);
					String[] dataExport = dataExports.get(i);
					for (int j = 0; j < dataExport.length; j++) {
						Cell cell = row.createCell(j);
						cell.setCellValue(dataExport[j]);
						cell.setCellStyle(style);
					}
				}
				rowPos += dataExports.size();
			}
		}

		ByteArrayOutputStream baos = new ByteArrayOutputStream();

		// fill the OutputStream with the Excel content
		workbook.write(baos);
		UUID uuid = UUID.randomUUID();
		String fileName = uuid.toString() + ".xlsx";
		String pathFile = utilityRepo.getUtilityByKey(EXCEL_EXPORT_DIRECTORY) + "/" + fileName;
		try (OutputStream outputStream = new FileOutputStream(pathFile)) {
			baos.writeTo(outputStream);
		}
		return fileName;
	}

}
